config = YAML.load_file('config/config.yml')["deployment"]["production"] || {}

set :user, config['user']
# Set RBEnv Stuff
set :default_environment, config['default_environment'] || {}
# Servers
role :web, config['hosts']['web'] # Your HTTP server, Apache/etc
role :app, config['hosts']['app'] # This may be the same as your `Web` server
role :db,  config['hosts']['db'], :primary => true # This is where Rails migrations will run
# Git Config
set :branch, config['branch']
# God Settings
set :deploy_to, config['deploy_to']
set :rails_env, :production
# Deploy Commands
# Override deploy to inform god to do the restarts.
