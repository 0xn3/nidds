#!/bin/sh
# Install
echo -e "\e[93mInstalling nidds Server \e[0m" ; sleep 5
apt update
apt install -y python-setuptools python-pcapy git schedtool
cd /tmp
git clone --depth 1 https://github.com/prasanthc41m/nidds.git
mv /tmp/nidds /opt
chown -R $USER:$USER /opt/nidds
# Set working environment
mkdir -p /var/log/nidds
mkdir -p /etc/nidds
#Add Remote Server:port IP
#read -p 'IP: ' ip
#echo "LOG_SERVER $ip:1019" >> /opt/nidds/nidds.conf
sed -i -e '/#UDP_ADDRESS/s/#UDP_ADDRESS/UDP_ADDRESS/' /opt/nidds/nidds.conf
sed -i -e '/#UDP_PORT/s/#UDP_PORT/UDP_PORT/' /opt/nidds/nidds.conf
#echo "UDP_ADDRESS 0.0.0.0 " >> /opt/nidds/nidds.conf
#echo "UDP_PORT 1019 " >> /opt/nidds/nidds.conf
cp /opt/nidds/nidds.conf /etc/nidds
# Adding cron job
echo -e "\e[93mUpdating cron job to autostart sensor & periodic restart \e[0m"
crontab <<EOF
*/1 * * * * if [ -n "$(ps -ef | grep -v grep | grep 'sensor.py')" ]; then : ; else python /opt/nidds/server.py -c /etc/nidds/nidds.conf; fi
0 1 * * * cd /opt/nidds && git pull
EOF
#python /opt/nidds/server.py -c /etc/nidds/nidds.conf &
echo -e "\e[93mInstallation Finished \e[0m"
#echo -e "\e[93mTesting Sensor \e[0m"
#ping -c 1 136.161.101.53
echo -e "\e[93m $(tail -n 2  /var/log/maltrail/$(date +"%Y-%m-%d").log)"
echo -e "\e[93mBrowse http://0.0.0.0:1020 \e[0m"
