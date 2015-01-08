class PracticeAPI::CommentApi < Grape::API
  resources :comments do
    helpers ::ToolKit


  end
end