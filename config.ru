require './config/environment'
use ActiveRecord::ConnectionAdapters::ConnectionManagement
use Rack::Cors do
  allow do
    origins '*'
    resource '/*', :headers => :any, :methods => [:get, :post, :options, :put, :delete],
             :expose => %w(Content-Range Accept-Ranges), :credentials => true
  end
end
use Rack::TryStatic, :root => 'web', :urls => %w[/], :try => %w(.html .js .css index.html .md)

map '/' do
  run PracticeAPI
end