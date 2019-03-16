# Bash-Scripts/minecraft_as_service

A small bash script to run a minecraft server as a linux service.


## What to do?

* Create server.

```
sudo mkdir /opt/minecraft/SERVERNAME
```

* Put **server.jar** inside the server directory.

* Create **minecraft@.service** file inside **/etc/systemd/system/**
```
sudo nano /etc/systemd/system/minecraft@.service
```

* Copy [this code](https://github.com/xPand4B/Bash-Scripts/blob/master/minecraft_as_service/minecraft@.service) inside the **minecraft@.service** file.


## Usage

```
sudo service minecraft@SERVERNAME {start | stop | restart}
```