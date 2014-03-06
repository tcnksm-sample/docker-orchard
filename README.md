# Sample of [ORCHARD](https://orchardup.com)

Sample development process with [docker]() and [ORCHARD](https://orchardup.com) on OSX.

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

Run boot2docker.

```bash
$ boot2docker init
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

## Development





