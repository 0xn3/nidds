#!/bin/sh
# Install
echo -e "\e[93mInstalling nidds Sensor \e[0m" ; sleep 5
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
read -p 'IP: ' ip
#echo "LOG_SERVER $ip:1019" >> /opt/nidds/nidds.conf
sed -i "97i\ \ LOG_SERVER $ip:1019" /opt/nidds/nidds.conf
cp /opt/nidds/nidds.conf /etc/nidds
# Adding cron job
echo -e "\e[93mUpdating cron job to autostart sensor & periodic restart \e[0m"
crontab <<EOF
*/1 * * * * if [ -n "$(ps -ef | grep -v grep | grep 'sensor.py')" ]; then : ; else python /opt/nidds/sensor.py -c /etc/nidds/nidds.conf; fi
2 1 * * * /usr/bin/pkill -f nidds
EOF
#python /opt/nidds/sensor.py -c /etc/nidds/nidds.conf &
echo -e "\e[93mInstallation Finished \e[0m"
echo -e "\e[93mTesting Sensor \e[0m"
ping -c 1 136.161.101.53
echo -e "\e[93m $(tail -n 2  /var/log/nidds/$(date +"%Y-%m-%d").log)"
echo -e "\e[93mCheck Dashboard \e[0m"
