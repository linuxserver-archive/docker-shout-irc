[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# PSA: Changes are happening

From August 2018 onwards, Linuxserver are in the midst of switching to a new CI platform which will enable us to build and release multiple architectures under a single repo. To this end, existing images for `arm64` and `armhf` builds are being deprecated. They are replaced by a manifest file in each container which automatically pulls the correct image for your architecture. You'll also be able to pull based on a specific architecture tag.

TLDR: Multi-arch support is changing from multiple repos to one repo per container image.

# [linuxserver/shout-irc](https://github.com/linuxserver/docker-shout-irc)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/shout-irc.svg)](https://microbadger.com/images/linuxserver/shout-irc "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/shout-irc.svg)](https://microbadger.com/images/linuxserver/shout-irc "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/shout-irc.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/shout-irc.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-shout-irc/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-shout-irc/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/shout-irc/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/shout-irc/latest/index.html)

[Shout-irc](http://shout-irc.com/) is a web IRC client that you host on your own server.

[![shout-irc](https://raw.githubusercontent.com/linuxserver/community-templates/master/lsiocommunity/img/shout-icon.png)](http://shout-irc.com/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list). 

Simply pulling `linuxserver/shout-irc` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=shout-irc \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/London \
  -p 9000:9000 \
  -v </path/to/appdata/config>:/config \
  --restart unless-stopped \
  linuxserver/shout-irc
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  shout-irc:
    image: linuxserver/shout-irc
    container_name: shout-irc
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Europe/London
    volumes:
      - </path/to/appdata/config>:/config
    ports:
      - 9000:9000
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 9000` | Application WebUI |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-v /config` | Configuration files. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


&nbsp;
## Application Setup

 * To log in to the application, browse to https://<hostip>:9000. * To setup user account(s) edit `/config/config.json` * Change the value `public: true,` to `public: false,` * restart the container and enter the following from the command line of the host: * `docker exec -it thelounge thelounge add <user>` * Enter a password when prompted, refresh your browser. * You should now be prompted for a password on the webinterface. 


## Support Info

* Shell access whilst the container is running: `docker exec -it shout-irc /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f shout-irc`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' shout-irc`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/shout-irc`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/shout-irc`
* Stop the running container: `docker stop shout-irc`
* Delete the container: `docker rm shout-irc`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start shout-irc`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update the image: `docker-compose pull linuxserver/shout-irc`
* Let compose update containers as necessary: `docker-compose up -d`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **28.01.19:** - Add pipeline logic and multi arch.
* **25.08.18:** - Rebase to alpine 3.8.
* **13.12.17:** - Rebase to alpine 3.7.
* **27.05.17:** - Rebase to alpine 3.6.
* **09.02.17:** - Rebase to alpine 3.5.
* **14.10.16:** - Add version layer information.
* **31.08.16:** - Rebase to alpine linux, move to lsiocommunity
