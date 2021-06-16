FROM alpine:3.14.0

LABEL NAME="docker-aptly" \
    maintainer="hello@cloudogu.com"

ENV DEBIAN_FRONTEND=noninteractive \
    APTLY_VERSION=1.4.0 \
    SHA256_APTLY="b3eb077d0e53b2361ab8db37b9bca1bf22018663274fddac0f3e4da6c48f1efb" \
	USER=aptly \
    GROUP=aptly


RUN set -xe \
  # create group and user for cas
  && addgroup -S -g 1000 ${GROUP} \
  && adduser -S -h "/var/lib/${USER}" -s /bin/bash -G ${GROUP} -u 1000 ${USER} \
  # upgrade and install dependencies
  && apk upgrade --quiet --no-cache \
  && apk add --quiet --no-cache libc6-compat curl xz bzip2 gnupg debian-archive-keyring nginx su-exec bash \
  # install aptly
  && mkdir -p /app/aptly \
  && curl --fail --silent --location --retry 3 -o aptly_${APTLY_VERSION}_linux_amd64.tar.gz \
   https://github.com/aptly-dev/aptly/releases/download/v${APTLY_VERSION}/aptly_${APTLY_VERSION}_linux_amd64.tar.gz \
  && tar zx -C /app/aptly --strip-components=1 -f aptly_${APTLY_VERSION}_linux_amd64.tar.gz \
  # clean up
  && apk del --quiet --no-cache --purge \
  && rm -rf /var/cache/apk/*

USER ${USER}

COPY --chown=${USER}:${GROUP} resources /

# expose volume
VOLUME [ "/var/lib/aptly" ]

# expose ports
EXPOSE 8080

# startup aptly
CMD /startup.sh
