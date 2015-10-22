FROM linuxserver/baseimage
MAINTAINER Gonzalo Peci <weedv2@outlook.com>
ENV APTLIST="nodejs-legacy npm"
ENV npm_config_loglevel="warn"

# Install APTLIST
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \

## Install Shout using NPM
npm -g install shout && \
npm cache clean && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


#Adding Custom files
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh


# Volumes and Ports
VOLUME /config
EXPOSE 9000
