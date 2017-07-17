#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "./hack/run update"
#
# DO NOT EDIT IT DIRECTLY.
#
FROM ruby:2.1
# <pre>

MAINTAINER AusNimbus <support@ausnimbus.com.au>

LABEL summary="Platform for running Ruby 2.1 applications" \
      maintainer="AusNimbus <support@ausnimbus.com.au>" \
      io.k8s.description="Platform for running Ruby 2.1 applications" \
      io.k8s.display-name="Ruby 2.1"

ENV USER=999 \
    HOME=/opt/app-root/src

USER 0

RUN apt-get update && apt-get install -y \
      rsync nano vim curl && \
      rm -rf /var/lib/apt/lists/* && \
    ln -sf /bin/bash /bin/sh && \
    mkdir -p $HOME && \
    useradd -u 1001 -g 0 -d $HOME -s /sbin/nologin \
      -c "Default Application User" default && \
    chown -R 1001:0 /opt/app-root

# Copy common executable utilities.
COPY ./common/bin/ /usr/bin/

# Each container image can have 'contrib' a directory with extra files needed to
# run and build the application.
COPY ./contrib/ /opt/app-root

# </pre>
# <s2i>

RUN apt-get update && apt-get install -y git --no-install-recommends && rm -rf /var/lib/apt/lists/*

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
# curb             libcurl3, libcurl3-gnutls, libcurl4-openssl-dev
# pg               libpq-dev
# rmagick          imagemagick, libmagickwand-dev
# nokogiri         libxml2-dev, libxslt-dev
# sqlite3          libsqlite3-dev
# mysql2           libmysqlclient-dev
# paperclip        file
# charlock_holmes  libicu-dev
# rugged           libgit2-dev

RUN apt-get update -y && \
    apt-get install -y -q --no-install-recommends \
        apt-utils \
        autoconf \
        build-essential \
        ca-certificates \
        cmake \
        curl \
        git \
        file \
        imagemagick \
        libcurl3 \
        libcurl3-gnutls \
        libcurl4-openssl-dev \
        libffi-dev \
        libgdbm-dev \
        libgit2-dev \
        libgmp-dev \
        libicu-dev \
        libmagickwand-dev \
        libmysqlclient-dev \
        libncurses5-dev \
        libpq-dev \
        libqdbm-dev \
        libreadline6-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxslt-dev \
        libyaml-dev \
        libz-dev && \
    rm -rf /var/lib/apt/lists/*

# </template>
# <post>

# Standardize on UID $USER
RUN usermod -o -u $USER default

# Drop the root user and make the content of /opt/app-root owned by user default
RUN chown -R $USER:0 /opt/app-root && chmod -R ug+rwx /opt/app-root
USER $USER

ENTRYPOINT ["container-entrypoint"]

# </post>
