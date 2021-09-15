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

Post install commands like pulling a docker hub image using podman pull
```
podman pull mcr.microsoft.com/mssql/server:2019-latest
```
Starting the downloaded image.
```
podman run -h "happy" -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=SuperStrongPa33Word!" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest
```
This document is for Educational Purposes, meaning purposes directly related to learning, teaching, training, and research and development.
