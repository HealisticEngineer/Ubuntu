#!/bin/bash
read -p 'New VM name: ' vmname
read -p 'New VM RAM MB: ' vmram
read -p 'New VM vCPU: ' vmcpu
## version for the image in numbers (14.04, 16.04, 18.04, etc.)
ubuntuversion="20.04"
## image type: ova, vmdk, img, tar.gz
imagetype="ova"

## URL to most recent cloud image
releases_url="https://cloud-images.ubuntu.com/releases/${ubuntuversion}/release/"
img_url="${releases_url}/ubuntu-${ubuntuversion}-server-cloudimg-amd64.${imagetype}"

## download a cloud image to run, and convert it to virtualbox 'vdi' format
img_dist="${img_url##*/}"
wget -c $img_url -O "$img_dist"

## create meta-data file
cat > meta-data <<EOF
instance-id: $vmname
local-hostname: $vmname
EOF

## create user-data file and a iso file with that user-data on it.
## User is ubuntu and password below.
seed_iso="${vmname}.iso"
cat > my-user-data <<EOF
#cloud-config
password: passw0rd
chpasswd: { expire: False }
ssh_pwauth: True
EOF
cloud-localds "$seed_iso" my-user-data
# IF THIS ERROR HAPPENED: missing 'genisoimage'.  Required for --filesystem=iso9660.
# apt-get install genisoimage


# Import applicance
/mnt/c/Program\ Files/Oracle/VirtualBox/Vboxmanage.exe import $img_dist --vsys 0 --vmname "$vmname" --memory $vmram --cpus $vmcpu
/mnt/c/Program\ Files/Oracle/VirtualBox/vboxmanage.exe storageattach "$vmname" --storagectl "IDE" --port 1 --device 0 --type dvddrive --medium "$seed_iso"
## start up the VM
/mnt/c/Program\ Files/Oracle/VirtualBox/VBoxManage.exe startvm "$vmname" --type headless
