FROM debian:8.10
LABEL maintainer="sebastian.sdorra@cloudogu.com"

ENV DEBIAN_FRONTEND=noninteractive \
    APTLY_VERSION=1.2.0

COPY resources/ /

RUN apt-get -q update \
 && apt-get -y install bzip2 gnupg gpgv xz-utils ca-certificates \
 && echo "deb http://repo.aptly.info/ squeeze main" > /etc/apt/sources.list.d/aptly.list \
 && apt-key adv --keyserver keys.gnupg.net --recv-keys ED75B5A4483DA07C \
 && apt-get -q update \
 && apt-get -y install aptly=${APTLY_VERSION} \
 && apt-get clean

# expose volume
VOLUME [ "/var/lib/aptly" ]

# expose ports
EXPOSE 8080

# startup aptly
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/aptly", "api", "serve"]
