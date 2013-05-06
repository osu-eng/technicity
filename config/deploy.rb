$:.unshift File.join(File.dirname(__FILE__), 'deploy') 
require "capistrano_database_yml"
require "capistrano_application_yml"

set :application, "technicity"

# Set up our application stages
set :stages, ["production", "staging"]
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :repository,  "git@github.com:osu-eng/technicity.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "deployer"
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :database_server, "db.web.engineering.osu.edu"

# RVM configuration
set :rvm_type, :system
set :rvm_ruby_string, '1.9.3'

role :web, "apps.web.engineering.osu.edu"
role :app, "apps.web.engineering.osu.edu"
role :db,  "apps.web.engineering.osu.edu", :primary => true

# Clean up old releases
after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

require "bundler/capistrano"
require "rvm/capistrano"
