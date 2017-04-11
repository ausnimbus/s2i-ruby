# Ruby S2I Docker images

[![Build Status](https://travis-ci.org/ausnimbus/s2i-ruby.svg?branch=master)](https://travis-ci.org/ausnimbus/s2i-ruby)

This repository contains the source for building various versions of
the Ruby application as a reproducible Docker image
[source-to-image](https://github.com/openshift/source-to-image)
to be run on [AusNimbus](https://www.ausnimbus.com.au/).

Images are built with Ruby binaries from ruby-lang.org
The resulting image can be run using [Docker](http://docker.io).

If you are interested in using SCL-based Ruby binaries, use [s2i-ruby-scl](https://github.com/ausnimbus/s2i-ruby-scl)

## Versions

The versions currently supported are:

- 2.1
- 2.2
- 2.3
- 2.4
