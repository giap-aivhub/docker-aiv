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

- Download the package from GitHub release

https://github.com/aiv-code/docker-aiv/releases

- Install package
```
dpkg -i avi_6.3.4_all.deb
```

## Configure the service
### PostgreSQL

Assume we are having a PostgreSQL server with superuser permission. Let's create a credential and database for AIV.

```
psql -U postgres

CREATE USER avi WITH PASSWORD 'avi_password';
CREATE DATABASE avi OWNER avi;
GRANT ALL PRIVILEGES ON DATABASE avi TO avi;

```
- Update the postgresql connection at configuration file `/etc/avi/econfig/application.yml`

```
spring:
  autoconfigure:
    exclude: org.springframework.boot.autoconfigure.mongo.MongoAutoConfiguration
  datasource:
    url: jdbc:postgresql://localhost:5432/aiv # database for aiv schema
    username: aiv
    password: aiv_password
    driverClassName: org.postgresql.Driver
  datasource1:
    url: jdbc:postgresql://localhost:5432/aiv?currentSchema=security # database for security schema
    username: aiv
    password: aiv_password
    driverClassName: org.postgresql.Driver

```

## Start the service
```
systemctl start avi
```

- Enable the service to start on boot
```
systemctl enable avi
```

## How to upgrade
- Download the new package from GitHub release

https://github.com/aiv-code/docker-aiv/releases

- Stop the service
```
systemctl stop avi
```

- Install the new package

```
dpkg -i avi_6.3.5_all.deb
```

- Restart the service
```
systemctl start avi
```
