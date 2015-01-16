require "#{__dir__}/../config/environment"

def app
  'PracticeAPI'
end

describe 'PracticeAPI' do
  include Rack::Test::Methods
  it '获取所有用户' do
    get '/api/users'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to eq User.all.as_json(only: [:username, :name, :email, :gender])
  end

  it '注册用户并登录' do
    post '/api/users/reg', username: 'test', password: '123456', gender: 0
    expect(last_response.status).to eq(201)
    json = JSON.parse(last_response.body)
    expect(json['username']).to eq 'test'

    post '/api/users/login', username: 'test', password: '123456'
    json = JSON.parse(last_response.body)
    expect(json['username']).to eq 'test'
  end

  it '获取当前登录用户' do
    post '/api/users/login', username: 'test', password: '123456'
    user = JSON.parse(last_response.body)

    get '/api/users/current'
    expect(JSON.parse(last_response.body)['username']).to eq user['username']
  end

  it '修改用户资料并且重新登录' do
    post '/api/users/login', username: 'test', password: '123456'
    user = JSON.parse(last_response.body)

    put "/api/users/#{user['id']}", name: 'test_user', email: 'abc@abc.com', gender: 1, password: '654321'
    new_user = JSON.parse(last_response.body)
    expect(new_user['name']).to eq 'test_user'
    expect(new_user['email']).to eq 'abc@abc.com'
    expect(new_user['gender']).to eq 1


    post '/api/users/login', username: 'test', password: '123456'
    expect(last_response.status).to eq(500)

    post '/api/users/login', username: 'test', password: '654321'
    after_user = JSON.parse(last_response.body)
    expect(after_user['username']).to eq('test')
  end

  it '删除用户' do
    post '/api/users/login', username: 'test', password: '123456'
    user = JSON.parse(last_response.body)

    delete "/api/users/#{user['id']}"
    expect(last_response.status).to eq(405)

    post '/api/users/login', username: 'test', password: '123456'
    expect(last_response.status).to eq(500)
  end
end