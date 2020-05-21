DeviseTokenAuth.setup do |config|

  # config.change_headers_on_each_request を true にしていると、
  # リクエストごとに token を新しくする必要がある という設定になってしまう
  # 毎回トークンを変更するのは手間なので false にしておく
  # config.token_lifspan はトークンの有効期限
  # セキュリティを重視するなら短めの設定にするなど、ここは個人の判断で

  config.change_headers_on_each_request = false
  config.token_lifespan = 1.month

  config.headers_names = {:'access-token' => 'access-token',
                          :'client' => 'client',
                          :'expiry' => 'expiry',
                          :'uid' => 'uid',
                          :'token-type' => 'token-type' }
end