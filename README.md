## NodeBB Dockerfile

This repository contains the **Dockerfile** of [NodeBB](https://nodebb.org/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/morphy/nodebb/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

*Inspired at [nickjanssen/docker-nodebb](https://github.com/morphy2k/docker-nodebb) and [dockerfile/ghost](https://github.com/dockerfile/ghost).*

### Base Docker Image

* [dockerfile/nodejs](http://dockerfile.github.io/#/nodejs)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/morphy/nodebb/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull morphy/nodebb`

(alternatively, you can build an image from Dockerfile: `docker build -t="morphy/nodebb" github.com/morphy2k/docker-nodebb`)

### Usage

First, run a Redis instance on your machine. It will automatically expose the `/data` volume.

`docker run --name redis -d dockerfile/redis`

Next, launch the NodeBB instance from this repository, so it links with the just-launched Redis instance.

`docker run -p 80:4567 --name nodebb --link redis:redis -P -t -i morphy/nodebb`

You will be asked to configure your NodeBB instance, as no config file was found. Simply press enter for all settings except Redis hostname, which should be `redis` as it is linked using the `--linked` parameter to our Redis instance, and the administrator username, e-mail and password.

NodeBB will launch the setup and automatically close. Next, simply start the instance again. It will this time find a config file and start as a daemon.

`docker start nodebb`

Your NodeBB instance will be accessible on port `80`.

### Backup/Restoring

Simply use the `/data` volume inside your Redis instance. See the [official guide on making backups](https://docs.docker.com/userguide/dockervolumes/#backup-restore-or-migrate-data-volumes).

#### Additional

`docker run -p 80:4567 -v <override-dir>:/nodebb-override --name nodebb --link redis:redis -P -t -i morphy/nodebb`

where `<override-dir>` is an absolute path of a directory that could contain:

  - `config.json`: config with url, port, redis password etc.
  - `public/`: images/uploads
  - `logs/`: log files
  - `node_modules/`:  plugins/themes
