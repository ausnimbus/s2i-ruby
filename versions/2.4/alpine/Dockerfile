#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "./hack/run update"
#
# DO NOT EDIT IT DIRECTLY.
#
FROM ruby:2.4-alpine
# <pre>

MAINTAINER AusNimbus <support@ausnimbus.com.au>

LABEL summary="Platform for running Ruby 2.4 applications" \
      maintainer="AusNimbus <support@ausnimbus.com.au>" \
      io.k8s.description="Platform for running Ruby 2.4 applications" \
      io.k8s.display-name="Ruby 2.4"

ENV USER=100 \
    HOME=/opt/app-root/src

USER 0

RUN apk --no-cache add bash rsync curl && \
    ln -sf /bin/bash /bin/sh && \
    mkdir -p $HOME && \
    adduser -S -u 1001 -G root -h $HOME -s /sbin/nologin \
      -g "Default Application User" default && \
    chown -R 1001:0 /opt/app-root

# Copy common executable utilities.
COPY ./common/bin/ /usr/bin/

# Each container image can have 'contrib' a directory with extra files needed to
# run and build the application.
COPY ./contrib/ /opt/app-root

# </pre>
# <s2i>

RUN apk --no-cache add git && rm -rf /var/cache/apk/*

ENV STI_SCRIPTS_PATH=/usr/libexec/s2i

LABEL io.openshift.expose-services="8080:http" \
    io.openshift.tags="builder,ruby" \
    io.openshift.s2i.scripts-url=image:///usr/libexec/s2i

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

# Directory with the sources is set as the working directory so all S2I scripts
# can execute relative to this path.
WORKDIR ${HOME}

EXPOSE 8080
CMD /usr/bin/base-usage

# </s2i>
# <template>

# Install dependencies for Ruby
# Also installs dependencies for the following common gems:
#
# gems             dependencies
# ------------------------------------------------------------------
# curb             libcurl, gnutls-dev, openssl-dev
# pg               postgresql-dev
# rmagick          imagemagick, imagemagick-dev
# nokogiri         libxml2-dev, libxslt-dev
# sqlite3          libsqlite3-dev
# mysql2           mariadb-dev
# paperclip        file
# charlock_holmes  icu-dev
# rugged           libgit2-dev

RUN apk add --no-cache \
        autoconf \
        build-base \
        ca-certificates \
        cmake \
        curl \
        git \
        file \
        imagemagick \
        libcurl \
        gnutls-dev \
        openssl-dev \
        libffi-dev \
        gdbm-dev \
        libgit2-dev \
        gmp-dev \
        icu-dev \
        imagemagick-dev \
        mariadb-dev \
        ncurses-dev \
        postgresql-dev \
        readline-dev \
        sqlite-dev \
        openssl-dev \
        libxml2-dev \
        libxslt-dev \
        yaml-dev \
        zlib-dev && \
    rm -rf /var/lib/apt/lists/*

# </template>
# <post>

# Standardize on UID $USER (alpine:3.4 does not have the shadow package)
RUN apk add shadow --no-cache --repository http://rsync.alpinelinux.org/alpine/latest-stable/community/ && \
    usermod -o -u $USER default && \
    apk del shadow

# Drop the root user and make the content of /opt/app-root owned by user default
RUN chown -R $USER:0 /opt/app-root && chmod -R ug+rwx /opt/app-root
USER $USER

ENTRYPOINT ["container-entrypoint"]

# </post>
