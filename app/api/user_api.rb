class PracticeAPI::UserApi < Grape::API
  format :json
  resources :users do
    helpers ::ToolKit

    desc '获取所有用户'
    get do
      User.all.as_json(only: [:username, :name, :email, :gender])
    end

    desc '注册用户'
    params do
      requires :username, type: String
      requires :password, type: String
      optional :gender, type: Integer
    end
    post :reg do
      error! message: '私人博客，暂时不开放注册！'
      User.reg(params[:username], params[:password], params[:gender]).safe_attributes
    end

    desc '登录'
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post :login do
      user = User.login params[:username], params[:password]
      user.response_to_cookie cookies
      user.safe_attributes
    end

    desc '注销'
    post :logout do
      User.logout cookies
    end

    desc '获取当前登录用户'
    get :current do
      @current_user.safe_attributes if @current_user
    end

    desc '某用户的操作'
    params do
      requires :id, type: String
    end
    namespace ':id' do
      after_validation do
        @user = User.find_by(id: params[:id])
      end

      desc '获取该用户数据'
      get do
        @user.safe_attributes
      end

      desc '修改该用户'
      params do
        optional :name, type: String
        optional :email, type: String
        optional :password, type: String
        optional :gender, type: Integer
      end
      put do
        @user.update! params[:name], params[:email], params[:password], params[:gender]
      end

      desc '删除该用户'
      delete do
        @user.destroy!
      end

    end
  end
end