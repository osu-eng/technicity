# 
# = Capistrano application.yml task
#
# Provides a couple of tasks for creating the application.yml 
# configuration file dynamically when deploy:setup is run.
#
# Category::    Capistrano
# Package::     Configuration
# Author::      Corey Hinshaw <hinshaw.25@osu.edu>
# License::     MIT License
#
# This task is based heavily on the database.yml task created by Simone
# Carletti <weppos@weppos.net> available at http://gist.github.com/2769.
#

unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end

Capistrano::Configuration.instance(:must_exist).load do

  namespace :deploy do

    namespace :env do

      desc <<-DESC
        Creates the application.yml configuration file in shared path.

        By default, this task creates an empty application.yml file \
        unless a template called application.yml.erb is found either \
        in :template_dir or /config/deploy folders.

        When this recipe is loaded, env:setup is automatically configured \
        to be invoked after deploy:setup. You can skip this task setting \
        the variable :skip_env_setup to true. This is especially useful \ 
        if you are using this recipe in combination with \
        capistrano-ext/multistaging to avoid multiple env:setup calls \ 
        when running deploy:setup for all stages one by one.
      DESC
      task :setup, :except => { :no_release => true } do

        default_template = <<-EOF
        # No application.yml template was found.
        EOF

        location = fetch(:template_dir, "config/deploy") + '/application.yml.erb'
        template = File.file?(location) ? File.read(location) : default_template

        config = ERB.new(template)

        run "mkdir -p #{shared_path}/config"
        put config.result(binding), "#{shared_path}/config/application.yml"
      end

      desc <<-DESC
        [internal] Updates the symlink for application.yml file to the just deployed release.
      DESC
      task :symlink, :except => { :no_release => true } do
        run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml" 
      end

    end

    after "deploy:setup",           "deploy:env:setup"   unless fetch(:skip_env_setup, false)
    after "deploy:finalize_update", "deploy:env:symlink"

  end

end
