sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved


sudo nano /etc/NetworkManager/NetworkManager.conf
under [Main]
dns=default

sudo rm /etc/resolv.conf

sudo systemctl restart NetworkManager


curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

docker pull pihole/pihole:latest

docker run -d \
    --name pihole \
    -p 53:53/tcp -p 53:53/udp \
    -p 80:80 \
    -p 443:443 \
    -v "$(pwd)/etc-pihole/:/etc/pihole/" \
    -v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
    --dns=127.0.0.1 --dns=1.1.1.1 \
    --restart=unless-stopped \
    pihole/pihole:latest

echo -e "\n$(docker logs pihole 2> /dev/null | grep 'password:') for your pi-hole: https://${IP}/admin/"
