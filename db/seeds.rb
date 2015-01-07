User.transaction do

  user = User.reg 'tavern', 'Tavern1001', 1
  account = OAuthAccount.create! avatar_hd: 'http://tp4.sinaimg.cn/1733849187/180/40008891551/1',
                                 avatar_large: 'http://tp4.sinaimg.cn/1733849187/180/40008891551/1',
                                 gender: 'm',
                                 id: 1733849187,
                                 idstr: '1733849187',
                                 lang: 'zh-cn',
                                 profile_image_url: 'http://tp4.sinaimg.cn/1733849187/50/40008891551/1',
                                 url: '',
                                 name: 'TavernGoal',
                                 screen_name: 'TavernGoal'
  user.o_auth_account = account
  account.user = user
end