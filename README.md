# AusNimbus Builder for Ruby  [![Build Status](https://travis-ci.org/ausnimbus/s2i-ruby.svg?branch=master)](https://travis-ci.org/ausnimbus/s2i-ruby) [![Docker Repository on Quay](https://quay.io/repository/ausnimbus/s2i-ruby/status "Docker Repository on Quay")](https://quay.io/repository/ausnimbus/s2i-ruby)

[![Ruby](https://user-images.githubusercontent.com/2239920/27285112-e0843ae8-553e-11e7-8f85-48a7ef36e002.jpg)](https://www.ausnimbus.com.au/)

The [AusNimbus](https://www.ausnimbus.com.au/) builder for Ruby applications provides a fast, secure and reliable Rack, Rails and [Ruby hosting](https://www.ausnimbus.com.au/languages/ruby-hosting/) environment.

It uses bundler for dependency management. The recommended webserver is Puma. Web processes must bind to port `8080`,
and only the HTTP protocol is permitted for incoming connections.

## Environment variables

* **RACK_ENV**

    This variable specifies the environment where the Ruby application will be deployed - `production`, `development`, `test`.
    Each level has different behaviours in terms of logging verbosity, error pages, ruby gem installation, etc.

    **Note**: Application assets will be compiled only if the `RACK_ENV` is set to `production`

* **DISABLE_ASSET_COMPILATION**

    This variable set to `true` indicates that the asset compilation process will be skipped. Since this only takes place
    when the application is run in the `production` environment, it should only be used when assets are already compiled.

* **PUMA_MIN_THREADS**, **PUMA_MAX_THREADS**

    These variables indicate the minimum and maximum threads that will be available in [Puma](https://github.com/puma/puma)'s thread pool.

* **PUMA_WORKERS**

    This variable indicate the number of worker processes that will be launched. See documentation on Puma's [clustered mode](https://github.com/puma/puma#clustered-mode).

* **RUBYGEM_MIRROR**

    Set this variable to use a custom RubyGems mirror URL to download required gem packages during build process.

## Hot deploy

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
