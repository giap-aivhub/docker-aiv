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
dpkg -i aiv_6.3.6_all.deb
```

## Configure the service
### PostgreSQL

Assume we are haivng a PostgreSQL server with superuser permission. Let's create a credential and database for AIV.

```
psql -U postgres

CREATE USER aiv WITH PASSWORD 'aiv_password';
CREATE DATABASE aiv OWNER aiv;
GRANT ALL PRIVILEGES ON DATABASE aiv TO aiv;

```
- Update the postgresql connection at configuration file `/etc/aiv/econfig/application.yml`

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
systemctl start aiv
```

- Enable the service to start on boot
```
systemctl enable aiv
```

## How to upgrade
- Download the new package from GitHub release

https://github.com/aiv-code/docker-aiv/releases

- Stop the service
```
systemctl stop aiv
```

- Install the new package

```
dpkg -i aiv_<version>_all.deb
```

- Restart the service
```
systemctl start aiv
```
