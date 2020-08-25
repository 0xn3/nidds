#!/bin/sh
apt install hostapd
systemctl unmask hostapd
systemctl enable hostapd
echo "[NetDev]" >> /etc/systemd/network/bridge-br0.netdev
echo "Name=br0" >> /etc/systemd/network/bridge-br0.netdev
echo "Kind=bridge" >> /etc/systemd/network/bridge-br0.netdev
echo "[Match]" >> /etc/systemd/network/br0-member-eth0.network
echo "Name=eth0" >> /etc/systemd/network/br0-member-eth0.network
echo " " >> /etc/systemd/network/br0-member-eth0.network
echo "[Network]" >> /etc/systemd/network/br0-member-eth0.network
echo "Bridge=br0" >> /etc/systemd/network/br0-member-eth0.network
echo "[Match]" >> /etc/systemd/network/br0-member-usb0.network
echo "Name=usb00" >> /etc/systemd/network/br0-member-usb0.network
echo " " >> /etc/systemd/network/br0-member-usb0.network
echo "[Network]" >> /etc/systemd/network/br0-member-usb0.network
echo "Bridge=br0" >> /etc/systemd/network/br0-member-usb0.network
systemctl enable systemd-networkd
sed -i "44i\denyinterfaces wlan0 eth0 usb0" /etc/dhcpcd.conf
echo "interface br0" >> /etc/dhcpcd.conf
rfkill unblock wlan
read -p 'Enter WiFi Name: ' ssid
read -p 'Enter WiFi Password: ' ssid_password
echo -e "Enter \e[93ma\e[0m for 2.5GHz and \e[93mg\e[0m for 5GHz"
read -p 'Enter WiFi Mode: ' mode
echo "
country_code=GB
interface=wlan0
bridge=br0
ssid=$ssid
hw_mode=$mode
channel=7
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=$ssid_password
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
 " > /etc/hostapd/hostapd.conf
echo -e "\e[93mYour device has setup for WiFi bridge-network, NIDDS sensor installing!\e[0m"
cd /tmp/ && wget https://raw.githubusercontent.com/prasanthc41m/nidds/master/install_sensor.sh && bash install_sensor.sh
echo -e "\e[93mYour NIDDS sensor installation finished! Restarting your Device!!\e[0m"
systemctl reboot
