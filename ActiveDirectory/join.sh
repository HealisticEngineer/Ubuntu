#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "domain is" $1
echo "AD Server is" $2
echo "user account is" $3
echo "computername is" $(hostname)
workstation=$(hostname)

apt install -y sssd heimdal-clients msktutil

#check content of krb5.conf file
#sudo cat > /etc/krb5.conf <<EOF
cat > /etc/krb5.conf <<EOF
[libdefaults]
default_realm = ${1^^}
rdns = no
dns_lookup_kdc = true
dns_lookup_realm = true

[realms]
${1^^} = {
kdc = ${2,,}.${1,,}
admin_server = ${2,,}.${1,,}
}
EOF

kinit $3
klist
msktutil -N -c -b 'CN=COMPUTERS' -s ${workstation,,}/${workstation,,}.${1,,} -k my-keytab.keytab --computer-name ${workstation^^} --upn ${workstation^^}$ --server ${2^^}.${1,,} --user-creds-only
msktutil -N -c -b 'CN=COMPUTERS' -s ${workstation,,}/${workstation,,} -k my-keytab.keytab --computer-name ${workstation^^} --upn ${workstation^^}$ --server ${2^^}.${1,,} --user-creds-only
kdestroy

mv my-keytab.keytab /etc/sssd/my-keytab.keytab
# /etc/sssd/sssd.conf
cat > /etc/sssd/sssd.conf <<EOF
[sssd]
services = nss, pam
config_file_version = 2
domains = ${1,,}

[nss]
entry_negative_timeout = 0
#debug_level = 5

[pam]
#debug_level = 5

[domain/${1,,}]
#debug_level = 10
enumerate = false
id_provider = ad
auth_provider = ad
chpass_provider = ad
access_provider = ad
dyndns_update = false
ad_hostname = ${workstation,,}.${1,,}
ad_server = ${2,,}.${1,,}
ad_domain = ${1,,}
ldap_schema = ad
ldap_id_mapping = true
fallback_homedir = /home/%u
default_shell = /bin/bash
ldap_sasl_mech = gssapi
ldap_sasl_authid = ${workstation,,}$
krb5_keytab = /etc/sssd/my-keytab.keytab
ldap_krb5_init_creds = true
EOF

sudo chmod 0600 /etc/sssd/sssd.conf
sed -i '/pam_unix.so/a\session required pam_mkhomedir.so skel=/etc/skel umask=0077' /etc/pam.d/common-session
tail /etc/pam.d/common-session
systemctl restart sssd

adduser $3 sudo
echo "#######################################"
echo 
echo "Please restart to enable domain logins"
echo
