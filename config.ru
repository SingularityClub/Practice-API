require './config/environment'
use ActiveRecord::ConnectionAdapters::ConnectionManagement
use Rack::Cors do
  allow do
    origins '*'
    resource '/*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
  end
end

map '/' do
  run PracticeAPI
end