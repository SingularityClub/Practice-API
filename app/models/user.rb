require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :articles, class_name: 'Article'
  has_many :available_articles, -> { where enable: true }, class_name: 'Article', foreign_key: :user_id
  has_one :o_auth_account
  validates :username, uniqueness: {case_sensitive: false, message: '已有该用户!'},
            length: {in: 4...32, message: '用户名在4-32个字符之内'}

  def safe_attributes
    self.as_json(only: [:username, :id, :name, :email, :gender])
  end

  def update!(name, email, password, gender, old_password)
    raise '密码错误，拒绝修改！' unless User.auth(self.username, Digest::SHA1.hexdigest(old_password+self.salt))

    self.name, self.email, self.gender = name, email, gender
    change_password password if password
    self.save!
    self.safe_attributes
  end

  def change_password(password)
    raise '密码最低长度是6位' if password.length<6

    self.salt = Digest::SHA1.hexdigest(rand.to_s) unless self.salt
    self.encrypted_password = Digest::SHA1.hexdigest(password+self.salt)
  end

  def response_to_cookie(cookies)
    hashcode = Digest::SHA1.hexdigest(self.encrypted_password+$config['base']['secret_key'])
    cookies[$config['base']['auth_cookie_name']] = {
        value: "#{self.username}@#{hashcode}",
        expires: Time.now+7.days,
        path: '/'
    }
  end

  class << self
    def find_or_reg(username='', admin=false)
      user = User.find_by(username: username, enable: true)
      user =reg(username, '123456', 0, admin) unless user
      user
    end

    def reg(username='', password='', gender=0, admin=false)
      salt = Digest::SHA1.hexdigest(rand.to_s)
      encrypted_password = Digest::SHA1.hexdigest(password+salt)
      user = User.new username: username, encrypted_password: encrypted_password,
                      gender: gender, salt: salt, admin: admin
      user.save!
      user
    end

    def login(username='', password='')
      user = User.find_by(username: username)
      raise '没有该用户！' unless user

      encrypted_password = Digest::SHA1.hexdigest(password+user.salt)
      authorized_user = User.auth(username, encrypted_password)
      raise '用户名或密码错误！' unless authorized_user
      authorized_user
    end

    def logout(cookies)
      cookies[$config['base']['auth_cookie_name']] = {
          expires: Time.now-7.days,
          path: '/'
      }
    end

    def auth_with_header(headers={})
      token = headers['Auth-Token']
      return nil unless token
      username, password = token.split(':')
      user = User.find_by(username: username)
      if user
        encrypted_password = Digest::SHA1.hexdigest(password+user.salt)
        User.auth(username, encrypted_password)
      end
    end

    def auth_with_cookie(cookies={})
      cookie = cookies[$config['base']['auth_cookie_name']]
      return nil unless cookie
      username, hashcode = cookie.to_s.split('@')
      user = User.find_by(username: username)
      if user
        result = hashcode == Digest::SHA1.hexdigest(user.encrypted_password+$config['base']['secret_key'])
        if result
          return user
        else
          User.logout cookies
          return nil
        end
      end
    end

    def auth(username, password)
      User.find_by(username: username, encrypted_password: password)
    end
  end

end