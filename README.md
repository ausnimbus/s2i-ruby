# AusNimbus Builder for Ruby  [![Build Status](https://travis-ci.org/ausnimbus/s2i-ruby.svg?branch=master)](https://travis-ci.org/ausnimbus/s2i-ruby) [![Docker Repository on Quay](https://quay.io/repository/ausnimbus/s2i-ruby/status "Docker Repository on Quay")](https://quay.io/repository/ausnimbus/s2i-ruby)

[![Ruby](https://user-images.githubusercontent.com/2239920/27285112-e0843ae8-553e-11e7-8f85-48a7ef36e002.jpg)](https://www.ausnimbus.com.au/)

The [AusNimbus](https://www.ausnimbus.com.au/) builder for Ruby applications provides a fast, secure and reliable Rack, [Rails](https://www.ausnimbus.com.au/apps/rails-hosting/) and [Ruby hosting](https://www.ausnimbus.com.au/languages/ruby-hosting/) environment.

This document describes the behaviour and environment configuration when running your Ruby apps on AusNimbus.

- [Runtime Environments](#runtime-environments)
- [Web Process](#web-process)
- [Dependency Management](#dependency-management)
- [Environment Configuration](#environment-configuration)
- [Advanced](#advanced)
  - [Build Customization](#build-customization)
    - [Asset Compilation](#asset-compilation)
    - [Configuring bundler](#configuring-bundler)
  - [Using Puma](#using-puma)
    - [Configuring Puma](#configuring-puma)
    - [Application Concurrency](#application-concurrency)
- [Extending](#extending)
  - [Build Stage (assemble)](#build-stage-assemble)
  - [Runtime Stage (run)](#runtime-stage-run)
  - [Persistent Environment Variables](#persistent-environment-variables)
- [Debug Mode](#debug-mode)
- [Troubleshooting](#troubleshooting)

## Runtime Environments

AusNimbus supports various Ruby versions.

The currently supported versions are `2.1`, `2.2`, `2.3`, `2.4`

## Web Process

Your application's web processes must bind to port `8080`.

AusNimbus handles SSL termination at the load balancer.

The recommended webserver is Puma and supports automatic optimization.

## Dependency Management

The builder uses the bundler for installing dependencies.

## Environment Configuration

The following environment variables are available for you to configure your Ruby environment:

NAME        | Description
------------|-------------
RACK_ENV    | The Ruby application environment. (Default: "production")

## Advanced

### Build Customization

#### Asset Compilation

When your app is running in `RACK_ENV=production`, the asset compilation task will be run by default.

If you wish to skip this process you may set the following environment variable:


NAME                       | Description
---------------------------|-------------
DISABLE_ASSET_COMPILATION  | Set this variable to `TRUE` will skip the asset compilation process.

#### Configuring bundler

If you would like to use a custom rubygem mirror you may use the following environment variable:

NAME            | Description
----------------|-------------
RUBYGEM_MIRROR  | Set this variable to use a custom RubyGems mirror URL to download required gem packages during build process.


### Using Puma

#### Configuring Puma

By default the builder will check to see if `./config/puma.rb` exists. If it does not exist the default builder provided config will be used.

You may alternatively specify another location for your puma config:

Name        | Description
------------|-------------
PUMA_CONFIG | Path to your `puma.rb` config file.

#### Application Concurrency

If you are using the builder provided (fallback) Puma config we automatically tune the number of workers for you based on the app instance size.

Size     | Value
---------|-------------
Small    | 2 Workers
Medium   | 4 Workers
Large    | 8 Workers
2xLarge  | 16 Workers

You may optionally change these default settings by configuring the following environment variable:

NAME             | Description
-----------------|-------------
WEB_CONCURRENCY  | Set the number of Puma workers. By default, it is calculated as above.

If you are not using the default Puma config the calculated `WEB_CONCURRENCY` variable is still made available to you.

## Extending

AusNimbus builders are split into two stages:

- Build
- Runtime

Both stages are completely extensible, allowing you to customize or completely overwrite each stage.

### Build Stage (assemble)

If you want to customize the build stage, you need to add the executable `.s2i/bin/assemble` file in your repository.

This file should contain the logic required to build and install any dependencies your application requires.

If you only want to extend the build stage, you may use this example:

```sh
#!/bin/bash

echo "Logic to include before"

# Run the default builder logic
. /usr/libexec/s2i/assemble

echo "Logic to include after"
```

### Runtime Stage (run)

If you only want to change the executed command for the run stage you may the following environment variable.

NAME        | Description
------------|-------------
APP_RUN     | Define a custom command to start your application. eg. `rack --host 0.0.0.0 --port 8080`

**NOTE:** `APP_RUN` will overwrite any builder's runtime configuration (including the [Debug Mode](#debug-mode) section)

Alternatively you may customize or overwrite the entire runtime stage by including the executable file `.s2i/bin/run`

This file should contain the logic required to execute your application.

If you only want to extend the run stage, you may use this example:

```sh
#!/bin/bash

echo "Logic to include before"

# Run the default builder logic
. /usr/libexec/s2i/run
```

As the run script executes every time your application is deployed, scaled or restarted it's recommended to keep avoid including complex logic which may delay the start-up process of your application.

### Persistent Environment Variables

The recommend approach is to set your environment variables in the AusNimbus dashboard.

However it is possible to store environment variables in code using the `.s2i/environment` file.

The file expects a key=value format eg.

```
KEY=VALUE
FOO=BAR
```

## Debug Mode

The AusNimbus builder provides a convenient environment variable to help you debug your application.

NAME        | Description
------------|-------------
DEBUG       | Set to TRUE will enable common debug settings

## Troubleshooting

### Why aren't my changes being picked up

In order to dynamically pick up changes made in your application source code, you need to make following steps:

### Ruby on Rails applications

Run the built Rails application with the `RAILS_ENV=development` or `DEBUG=true` environment variable

### For other types of Ruby applications (Sinatra, Padrino, etc.)

Your application needs to be built with one of gems that reloads the server every time changes in source code are done. Some examples are:

* [Shotgun](https://github.com/rtomayko/shotgun)
* [Rerun](https://github.com/alexch/rerun)
* [Rack-livereload](https://github.com/johnbintz/rack-livereload)
