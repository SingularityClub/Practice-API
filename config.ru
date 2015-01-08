require './config/environment'
use ActiveRecord::ConnectionAdapters::ConnectionManagement
use Rack::Cors do
  allow do
    origins '*'
    resource '/api/*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
  end
end

map '/api' do
  run PracticeAPI
end