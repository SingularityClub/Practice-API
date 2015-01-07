class Etrain::TagApi < Grape::API
  resources :tags do
    get do
      Tag.all
    end
  end
end