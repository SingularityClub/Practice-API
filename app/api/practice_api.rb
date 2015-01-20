class PracticeAPI < Grape::API
  include Grape::ActiveRecord::Extension
  format :json


  after do
    header 'Access-Control-Allow-Origin', '*'
    header 'Access-Control-Allow-Methods', '*'
    header 'Access-Control-Allow-Headers', 'x-requested-with'
  end

  rescue_from :all do |e|
    error_response status: 500, message: {message: e.message, class: e.class.name, statck: e.backtrace}.as_json
  end

  require "#{__dir__}/user_api"
  require "#{__dir__}/article_api"
  require "#{__dir__}/tag_api"

  params do
    requires :username, type: String
  end
  namespace ':username' do
    after_validation do
      error!({message: '请求错误，请保证你的用户名在4-32之间！'}.as_json, 400) unless params[:username].length>4 and params[:username].length<=32

      #领域用户
      @space_user= User.find_or_reg(params[:username], false)
      #当前登录用户
      @current_user= User.auth_with_cookie cookies
    end

    mount PracticeAPI::UserApi => '/'
    mount PracticeAPI::ArticleApi => '/'
    mount PracticeAPI::TagApi => '/'
  end

end