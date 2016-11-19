# symfony.dev
Symfony on Docker

First, clone this repository:

```bash
$ git clone git@github.com:DjangoFR/symfony.dev.git
```

# Tools you need on your host

```text
docker
docker-compose (>= 1.6)
  -> $ ./bin/docker-compose-install.sh
wget
phpstorm
```

# Add following to /etc/hosts
```bash
127.0.0.1	symfony.dev
```

# Installation

```bash
$ ./bin/build.sh 
$ ./bin/start.sh 
$ ./bin/symfony.sh 
```

# Now you can start to

### connect to mysql

```bash
$ ./bin/mysql.sh
```
### open TTY to one of containers

```bash
$ ./bin/tty.sh
```
and follow instructions.



