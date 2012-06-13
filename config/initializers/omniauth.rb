# -*- encoding : utf-8 -*-
Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  #provider :Renren, 'bd84a1264b674b8c946c3effe1048779', '4ba014c9c2d94affad726ab99aee1b7f'
  provider :Weibo, '2901048510', 'c6a8cc347c5077d5889ccf275a206d99'
  #provider :Tsina, '2901048510', 'c6a8cc347c5077d5889ccf275a206d99'
  #provider :Twitter, "YPEbJ2rUT4lFhZWYPCIBw", "x6xGNd2b2TGF03wAFOSEDve0i3slydKvEts0pOrUbM"
end
