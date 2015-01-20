class PracticeAPI < Grape::API
  include Grape::ActiveRecord::Extension
  format :json

  before do
    @current_user= User.auth_with_cookie cookies
  end

  rescue_from :all do |e|
    error_response status: 500, message: {message: e.message, class: e.class.name, statck: e.backtrace}.as_json
  end

  require "#{__dir__}/user_api"
  require "#{__dir__}/article_api"
  require "#{__dir__}/tag_api"
  require "#{__dir__}/comment_api"

  params do
    requires :space, type: String
  end
  namespace ':space' do
    after_validation do
      p params[:space]
    end

    mount PracticeAPI::UserApi => '/'
    mount PracticeAPI::ArticleApi => '/'
    mount PracticeAPI::TagApi => '/'
    mount PracticeAPI::CommentApi => '/'
  end

end