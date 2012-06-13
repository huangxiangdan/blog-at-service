# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  
  def create
    puts request.env["omniauth.auth"]["credentials"].inspect
    
    # secret="82cc722f91a55b976edcfdba0b299ea7" token="67aadbbee5fba6d24f3d0725d5b8b40d"
    
    # expires_at= request.env["omniauth.auth"]["credentials"]["expires_at"]
    # 
    # puts expires_at
    # 
    # user = User.from_web_oauth(request.env["omniauth.auth"])
    # user.renren_token_expiration_date = Time.at(expires_at.to_i).to_datetime
    # user.save
    # 
    # existing_user_rids = User.existing_user_rids
    # ComputedInvite.recompute(user, existing_user_rids)
    # 
    # sign_in (user, "web")
    # redirect_to root_path, :notice => "人人登录成功，欢迎#{user.name}同学"
    render :json => "success"
  end
  
  def weibo
    # secret="bc4a7efbbab850bd28550eeae89f0a6a" token="aadd2a1ee9fbf01270c34d6cec808a61"
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)    
    oauth.authorize_from_access("aadd2a1ee9fbf01270c34d6cec808a61", "bc4a7efbbab850bd28550eeae89f0a6a")
    weibo_api = Weibo::Base.new(oauth)
    begin
      content = "test"
      weibo_api.update(content)
    rescue Exception => ex
      logger.error ex
    end
    render :json => "success"
  end
end
