source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem 'sqlite3'
  gem 'meta_request'
  gem 'better_errors'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'devise'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'cancan'
gem 'jquery-rails'
gem 'simple_form', '~> 2.1.0'
gem 'friendly_id'
gem 'geocoder'
gem 'figaro'
gem 'virtus'

gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'handles_sortable_columns'

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
gem 'capistrano'
gem 'rvm-capistrano', '>= 1.3.0'

# To use debugger
# gem 'debugger'

group :production do
  gem 'mysql2'
end
