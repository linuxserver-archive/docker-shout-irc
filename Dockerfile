FROM lsiobase/alpine:3.9

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SHOUTIRC_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment settings
ENV NPM_CONFIG_LOGLEVEL info

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	jq \
	nodejs-npm && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	nodejs && \
 echo "**** install shout-irc ****" && \
 if [ -z ${SHOUTIRC_VERSION+x} ]; then \
        SHOUTIRC_VERSION=$(curl -sL https://replicate.npmjs.com/registry/shout \
        |jq -r '. | .["dist-tags"].latest'); \
 fi && \
 mkdir -p \
	/app && \
 cd /app && \
 npm config set unsafe-perm true && \
 npm install -g \
	css-select \
	shout@${SHOUTIRC_VERSION} && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root && \
 mkdir -p / \
	/root

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 9000
VOLUME /config
