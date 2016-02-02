FROM linuxserver/baseimage
MAINTAINER Gonzalo Peci <weedv2@outlook.com>
ENV APTLIST="git-core nodejs" NPMLIST="css-select shout" npm_config_loglevel="warn"

# Install APTLIST
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
apt-get update -q && \
apt-get install $APTLIST -qy && \

## Install Shout using NPM
npm install -g $NPMLIST && \
npm cache clean && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh


# Volumes and Ports
VOLUME /config
EXPOSE 9000
