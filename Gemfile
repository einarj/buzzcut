source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  #gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platforms => :ruby
  gem 'less-rails'
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
  gem 'twitter-text'
end

group :development, :test do
  gem 'debugger'
  #gem 'rspec-rails', '~> 2.0'
  gem 'rspec-rails', '>= 2.14.0.rc1'
  gem 'mongoid-rspec', :github => 'evansagge/mongoid-rspec'
end

group :test do
  gem 'simplecov', :require => false, :github => 'colszowka/simplecov'
  gem 'factory_girl_rails', :github => 'thoughtbot/factory_girl_rails'

  gem 'database_cleaner', :github => 'bmabey/database_cleaner'
end

gem 'jquery-rails'

gem "mongoid", "~> 3.1.0"
gem 'bson_ext'

gem 'omniauth', :git => 'https://github.com/intridea/omniauth.git'
gem 'omniauth-oauth'
gem 'omniauth-twitter', :git => 'https://github.com/arunagw/omniauth-twitter.git'

gem 'crack'
gem 'twitter'

# Update tweets periodically in the background
gem "resque"
gem 'resque-scheduler', :require => 'resque_scheduler'
