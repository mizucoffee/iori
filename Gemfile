source 'https://rubygems.org'

gem 'debase'
gem 'fastri', require: false
gem 'rcodetools', require: false
gem 'rubocop', require: false
gem 'ruby-debug-ide', require: false

gem 'activerecord', '< 5.0.0'
gem 'dotenv'
gem 'rake'
gem 'sinatra'
gem 'sinatra-activerecord'
gem 'twitter'
gem 'rmagick'

gem "bundler", :require => [
  "pp",
  "uri"
]

group :test do
  gem 'codecov', require: false
  gem 'rack-test'
  gem 'simplecov', require: false
  gem 'rspec'
end

group :development do
  gem 'sinatra-contrib'
  gem 'sqlite3', '~> 1.3.6'
end

group :production do
  gem 'pg', '0.18'
end
