class OAuthAccount < ActiveRecord::Base
  has_one :user
  has_many :comments

  class << self
    def update_from_web(account)
      if account and account.id
        _account = OAuthAccount.find account.id
        _account.id, _account.idstr, _account.screen_name, _account.name, _account.url, _account.profile_image_url, _account.gender, _account.avatar_large, _account.avatar_hd, _account.lang =
            account.id, account.id.to_s, account.screen_name, account.name, account.url, account.profile_image_url, account.gender, account.avatar_large, account.avatar_hd, account.lang
        _account.save!
        _account
      end
    end
  end
end