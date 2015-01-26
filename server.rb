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
    headers_res= result[1]

    headers_res['Range']=headers_res['Content-Range'] if headers_res['Content-Range']

    headers_res['Access-Control-Allow-Origin'] = 'http://localhost:63342' unless headers_res['Access-Control-Allow-Origin']
    headers_res['Access-Control-Allow-Methods'] = 'GET,POST,PUT,DELETE,HEADER,OPTIONS'
    headers_res['Access-Control-Allow-Headers'] = 'Range-Unit,Range,Content-Type,Origin '
    headers_res['Access-Control-Allow-Credentials'] = 'true'
    headers_res['Access-Control-Expose-Headers'] = 'Content-Range,Accept-Ranges'

    result
  end
end