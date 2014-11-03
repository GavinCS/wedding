source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use mysql as the database for Active Record
gem 'mysql2'

gem 'bootstrap-sass'
gem 'simple_form'
gem 'mini_magick'
gem 'jquery-rails'
gem 'twitter'
gem 'geocoder'
gem 'gmaps4rails'
gem 'lodash-rails' , '~> 2.4.1'

gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'therubyracer', platforms: :ruby
  gem 'carrierwave'

end

group :development, :test do
  gem 'rails_layout'
  gem 'nifty-generators'
  gem 'letter_opener', '~> 1.2.0'
  gem 'rspec-rails'   , '~> 3.0.0.beta'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'capybara', '2.2.1'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
end

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use Capistrano for deployment
gem 'capistrano', '~> 3.0', require: false,  group: :development

gem "mocha", group: :test