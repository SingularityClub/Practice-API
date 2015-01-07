require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :articles, class_name: 'Article'
  has_one :o_auth_account
  validates :username, uniqueness: {case_sensitive: false, message: '已有该用户!'},
            length: {in: 4...32, message: '用户名在4-32个字符之内'}

  def safe_attributes
    self.as_json(only: [:username, :id, :name, :email, :gender])
  end

  def update(name, email, password, gender)
    self.name, self.email, self.gender = name, email, gender
    change_password password if password

    self.save!
  end

  def change_password(password)
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
    def reg(username='', password='', gender=0)
      salt = Digest::SHA1.hexdigest(rand.to_s)
      encrypted_password = Digest::SHA1.hexdigest(password+salt)
      user = User.new username: username, encrypted_password: encrypted_password, gender: gender, salt: salt
      user.save!
      user
    end

    def login(username='', password='')
      user = User.find_by(username: username)
      p user
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