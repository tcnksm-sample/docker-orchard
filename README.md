# Sample of [ORCHARD](https://orchardup.com)

Sample Rails application development process with [docker](https://www.docker.io/) and [ORCHARD](https://orchardup.com) on OSX.

## Setup

Install docker.

```bash
$ brew update
$ brew tap homebrew/binary
$ brew install docker
```

Install boot2docker.

```bash
$ brew install boot2docker
```

Initialize boot2docker.

```bash
$ boot2docker init
```

Portforward your boot2docker-vm.

```bash
$ VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port3000,tcp,,3000,,3000"
```

Up boot2docker.

```bash
$ boor2docker up
```

Set docker host.

```
$ export DOCKER_HOST=tcp://localhost:4243
```

Install orchard commandline-tool

```bash
$ curl -L https://github.com/orchardup/go-orchard/releases/download/2.0.5/darwin > /usr/local/bin/orchard
$ chmod +x /usr/local/bin/orchard
```

## Setup (Rails application)

For sample Rails application, use [mkwiatkowski/todo-rails4-angularjs](https://github.com/mkwiatkowski/todo-rails4-angularjs).

```
$ git clone https://github.com/mkwiatkowski/todo-rails4-angularjs
```

Edit database configure `config/database.yml` to link between containers.

```yaml
development:
  adapter: postgresql
  template: template0
  encoding: unicode
  database: todo_rails4_angularjs_development
  pool: 5
  username: docker
  password: docker
  host: <%= ENV.fetch('DB_PORT_5432_TCP_ADDR') %>
  port: <%= ENV.fetch('DB_PORT_5432_TCP_PORT') %>
```

Generate Dockerfile for Rails by [rbdock](https://github.com/tcnksm/rbdock).

```bash
$ gem install rbdock
$ rbdock 2.0.0-p247 --app todo-rails4-angularjs
```

## Development on local

On local development, use boot2docker for docker host.

Run PostgreSQL container [orchardup/postgresql]().

```bash
$ docker run -d -p 5432:5432 -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -name pg orchardup/postgresql
```

Build rails image and run container.

```bash
$ docker build -t tcnksm/rails .
$ docker run -i -p 3000:3000 -link pg:db -name web -t tcnksm/rails 'rake db:create && rake db:migrate && rails s'
```

Access to [localhost:3000](http://localhost:3000)

## Work with [ORCHARD](https://orchardup.com/)

Login to orchard and create host.

```
$ orchard hosts create
Orchard username: tcnksm
Password:
Default host running at 162.243.93.47
```

Create PostgreSQL container with [orchardup/postgresql]().

```bash
$ orchard docker run -d -p 5432:5432 -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -name pg orchardup/postgresql
```

Create Rails image and run it.

```bash
$ orchard docker build -t tcnksm/rails .
$ orchard docker run -i -p 3000:3000 -link pg:db -name web -t tcnksm/rails 'rake db:create && rake db:migrate && rails s'
```

Check host.

```bash
$ orchard hosts
NAME                SIZE                IP
default             512M                162.243.93.47
```

Access [162.243.93.47:3000](http://162.243.93.47:3000/).


If you delete your host run below.

```bash
$ orchard hosts rm
```
