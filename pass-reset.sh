
#!/bin/bash
sed -e '/admin:/ s/^#*/#/' -i /opt/nidds/nidds.conf
read -p 'Enter new admin password: ' password
echo -n $password | sha256sum | cut -d " " -f 1 > newpass.txt
hash=`cat newpass.txt`
sed -i "24i\ \ admin:$hash:0:\ \ \ \#$password" /opt/nidds/nidds.conf
rm -rf newpass.txt
cp -r /opt/nidds/nidds.conf /etc/nidds/nidds.conf
echo -e "Your admin password has changed to \e[93m$password\e[0m, restarting server!!"
pkill -f server.py
python /opt/nidds/server.py -c /etc/nidds/nidds.conf &

