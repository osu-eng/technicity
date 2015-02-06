source 'https://rubygems.org'

gem 'rails', '3.2.16'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem 'meta_request'
  gem 'better_errors'
end

group :development, :test do
  gem 'factory_girl_rails', '~> 4.3'
  gem 'rspec-rails', '~> 2.14'
  gem 'sqlite3'
end

group :test do
  gem 'capybara', '~> 2.2'
  gem 'rake'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass', '=2.3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'devise', '~> 3.2.2'
gem 'omniauth-twitter', '~> 1.0.1'
gem 'omniauth-facebook', '~> 1.5.1'
gem 'cancan', '~> 1.6.10'
gem 'jquery-rails', '~> 3.0.4'
gem 'jquery-ui-rails', '~> 4.1.1'
gem 'simple_form', '~> 2.1.0'
gem 'friendly_id', '~> 4.0.10'
gem 'geocoder', '~> 1.1.9'
gem 'figaro', '~> 0.7.0'
gem 'virtus', '~> 1.0.1'
gem 'nested_form', '~> 0.3.2'
gem 'twitter-bootstrap-rails-confirm', '~> 1.0.2'
gem 'ranked-model', '= 0.3'
gem 'will_paginate', '~> 3.0.5'
gem 'bootstrap-will_paginate', '= 0.0.10'
gem 'handles_sortable_columns', '= 0.1.4'
gem 'newrelic_rpm', '~> 3.9.9'
gem 'recaptcha', :require => 'recaptcha/rails'

# This doesn't seem to do what we need
# gem 'gmaps4rails'

# Alternate server for development
# See http://stackoverflow.com/questions/7082364/what-does-warn-could-not-determine-content-length-of-response-body-mean-and-h
gem 'thin'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', '~> 2.15.5'
gem 'rvm-capistrano', '>= 1.5.1'

# To use debugger
# gem 'debugger'

group :production do
  gem 'mysql2'
end
