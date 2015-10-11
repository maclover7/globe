source 'https://rubygems.org'

ruby '2.2.3'

# Rails Dependencies
gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Globe Dependencies
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-sass'
gem 'devise'
gem 'sidekiq'
gem 'puma'
gem 'sinatra'

# Rails Assets Dependencies
source 'https://rails-assets.org' do
  gem 'rails-assets-sweetalert'
end

# Environment Dependencies
group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'coveralls', require: false
  gem 'pry'
  gem 'sqlite3'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'shoulda'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
