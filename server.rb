require './config/environment'
require 'goliath'
class Application < Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::Render
  use ActiveRecord::ConnectionAdapters::ConnectionManagement

  # use Goliath::Rack::Render, 'json'
  use Rack::TryStatic, :root => 'web', :urls => %w[/], :try => %w(.html .js .css index.html .md)

  def response(env)
    result = ::PracticeAPI.call(env)
    headers= result[1]
    headers['Access-Control-Allow-Origin'] = 'localhost,127.0.0.1'
    headers['Access-Control-Allow-Methods'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Range-Unit,Range,Content-Type'
    result
  end
end