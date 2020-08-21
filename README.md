![NIDDS]()


## Quick start

The following set of commands should get your NIDDS **Sensor** up and running (out of the box with default settings and monitoring interface "any"):

- For **Debian/Ubuntu**

```
sudo su
bash install_sensor.sh
```
![Sensor]()

To start the (optional) **Server** on same machine, open a new terminal and execute the following:

```
sudo su
bash install_server.sh
```

![Server]()

To test that everything is up and running execute the following:

```
ping -c 1 136.161.101.53
cat /var/log/nidds/$(date +"%Y-%m-%d").log
```

![Test](https://#.png)

Also, to test the capturing of DNS traffic you can try the following:

```
nslookup morphed.ru
cat /var/log/nidds/$(date +"%Y-%m-%d").log
```

![Test2](https://#.png)

To stop **Sensor** and **Server** instances (if running in background) execute the following:

```
sudo pkill -f sensor.py
pkill -f server.py
```

Access the reporting interface (i.e. **Client**) by visiting the http://127.0.0.1:1020 (default credentials: `admin:changeme!`) from your web browser:

![Reporting interface]()



