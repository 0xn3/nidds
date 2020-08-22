![NIDDS]()


## Quick start

The following set of commands should get your NIDDS **Sensor** up and running (out of the box with default settings and monitoring interface "any"):

- For **Debian/Ubuntu**

![Sensor]( https://raw.githubusercontent.com/prasanthc41m/nidds/master/install_sensor.sh 
)
```
sudo su
cd /tmp/ && rm install_sensor.sh && wget https://raw.githubusercontent.com/prasanthc41m/nidds/master/install_sensor.sh && bash install_sensor.sh
```


To start the (optional) **Server** on same machine, open a new terminal and execute the following:

![Server](  https://raw.githubusercontent.com/prasanthc41m/nidds/master/install_server.sh 
)
```
sudo su
cd /tmp/ && rm install_server.sh && wget https://raw.githubusercontent.com/prasanthc41m/nidds/master/install_server.sh && bash install_server.sh
```



To test that everything is up and running execute the following:

```
ping -c 1 136.161.101.53
tail -n 3 /var/log/nidds/$(date +"%Y-%m-%d").log
```

![Test](https://raw.githubusercontent.com/prasanthc41m/nidds/master/images/Test1.png)

Also, to test the capturing of DNS traffic you can try the following:

```
nslookup morphed.ru
tail -n 3 /var/log/nidds/$(date +"%Y-%m-%d").log
```

![Test2](https://raw.githubusercontent.com/prasanthc41m/nidds/master/images/Test2.png)

To stop **Sensor** and **Server** instances (if running in background) execute the following:

```
sudo pkill -f sensor.py
pkill -f server.py
```
Access the reporting interface (i.e. **Client**) by visiting the http://127.0.0.1:1020 (default credentials: `admin:ehackify`) from your web browser:

![Reporting interface]()

To **change** Admin **password**

```
sudo su
cd /tmp/ && pass-reset.sh && wget https://raw.githubusercontent.com/prasanthc41m/nidds/master/pass-reset.sh && bash pass-reset.sh
```
