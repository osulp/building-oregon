# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
task(:default).clear
task :default => [:spec]

#IP_URL = "https://github.com/projectblacklight/blacklight-jetty/archive/v4.9.0.zip"
#require 'jettywrapper'
#require 'solr_wrapper/rake_task' unless Rails.env.production?
