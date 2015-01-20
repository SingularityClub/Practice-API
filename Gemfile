source 'http://ruby.taobao.org'

gem 'activerecord', require: 'active_record'
gem 'rack'

gem 'grape'
gem 'rake'
gem 'grape-activerecord'
gem 'rack-cors', :require => 'rack/cors'
gem 'rack-contrib', git: 'https://github.com/sebglazebrook/rack-contrib.git'

gem 'goliath', :require => false

group :production do
  #gem 'mysql2'
end

group :test, :development do
  gem 'rack-test'
  gem 'rspec'
  gem 'sqlite3'
end