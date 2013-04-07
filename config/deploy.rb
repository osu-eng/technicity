$:.unshift File.join(File.dirname(__FILE__), 'deploy') 
require "capistrano_database_yml"

set :application, "technicity"
set :deploy_to, "/var/www/apps/#{application}"

set :repository,  "git@github.com:osu-eng/technicity.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "deployer"
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :database_user, "technicity"
set :database_server, "db.web.engineering.osu.edu"

# RVM configuration
set :rvm_type, :system
set :rvm_ruby_string, '1.9.3'

role :web, "apps.web.engineering.osu.edu"
role :app, "apps.web.engineering.osu.edu"
role :db,  "apps.web.engineering.osu.edu", :primary => true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

require "rvm/capistrano"     
require "bundler/capistrano"
