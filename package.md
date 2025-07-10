# Debian family
## Os support (tested)
- Debian 11, 12
- Ubuntu 20*, 22*, 24*

## Installation steps

- Install dependencies
```
apt-get update

apt-get install -y \
    openjdk-17-jdk-headless \
    ca-certificates

```

- Download the package
```
wget https://github.com/giap-aivhub/docker-aiv/releases/download/debian%2F6.3.6/aiv_6.3.6_all.deb
```


- Install package
```
dpkg -i aiv_6.3.6_all.deb
```

- Configure the service
Update the postgresql connection at configuration file `/etc/avi/econfig/application.yml`

- Start the service
````
systemctl start avi
```

