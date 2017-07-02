# AusNimbus Builder for Ruby  [![Build Status](https://travis-ci.org/ausnimbus/s2i-ruby.svg?branch=master)](https://travis-ci.org/ausnimbus/s2i-ruby) [![Docker Repository on Quay](https://quay.io/repository/ausnimbus/s2i-ruby/status "Docker Repository on Quay")](https://quay.io/repository/ausnimbus/s2i-ruby)

[![Ruby](https://user-images.githubusercontent.com/2239920/27285112-e0843ae8-553e-11e7-8f85-48a7ef36e002.jpg)](https://www.ausnimbus.com.au/)

The [AusNimbus](https://www.ausnimbus.com.au/) builder for Ruby applications provides a fast, secure and reliable Rack, [Rails](https://www.ausnimbus.com.au/apps/rails-hosting/) and [Ruby hosting](https://www.ausnimbus.com.au/languages/ruby-hosting/) environment.

It uses bundler for dependency management. The recommended webserver is Puma. Web processes must bind to port `8080`,
and only the HTTP protocol is permitted for incoming connections.

## Environment variables

* **APP_RUN**

    Define the application command to be run. This can be a command to start the application.

    **NOTE:** This overwrites any builder dynamic run configuration.

* **RACK_ENV**

    This variable specifies the environment where the Ruby application will be deployed - `production`, `development`, `test`.

* **DISABLE_ASSET_COMPILATION**

    Set this variable to `TRUE` will skip the asset compilation process. By default asset complication only occurs when the application is run in the `production` environment.

* **RUBYGEM_MIRROR**

    Set this variable to use a custom RubyGems mirror URL to download required gem packages during build process.

If you are using Puma, you may use the following environment variables.

* **PUMA_CONFIG**

    Path to your `puma.rb` config file. By default it will try to use `./config/puma.rb` or fall back to the provided config file.

* **WEB_CONCURRENCY**

    Set this to change the default setting for the number of
    workers. By default, this is auto configured based on the `MEMORY_LIMIT`

## Debug Mode

In order to dynamically pick up changes made in your application source code, you need to make following steps:

*  **For Ruby on Rails applications**

    Run the built Rails application with the `RAILS_ENV=development` environment variable

*  **For other types of Ruby applications (Sinatra, Padrino, etc.)**

    Your application needs to be built with one of gems that reloads the server every time changes in source code are done inside the running container. Some examples are:

    * [Shotgun](https://github.com/rtomayko/shotgun)
    * [Rerun](https://github.com/alexch/rerun)
    * [Rack-livereload](https://github.com/johnbintz/rack-livereload)

## Versions

The versions currently supported are:

- 2.1
- 2.2
- 2.3
- 2.4
