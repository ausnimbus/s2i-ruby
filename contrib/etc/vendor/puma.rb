bind        'tcp://0.0.0.0:8080'
environment ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'production'

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!
