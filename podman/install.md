## Installing Podman on Ubuntu 20.04

1. First switch to sudo or root to perform the install.
1. Install curl, wget and gnupn2 if not already installed.
1. Add the sources so that apt command can be used to install podman.

```
sudo su -
apt update -y && apt upgrade -y
apt install curl wget gnupg2 -y
source /etc/os-release
sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | apt-key add -
apt update -qq -y
apt -qq --yes install podman
podman --version
```
