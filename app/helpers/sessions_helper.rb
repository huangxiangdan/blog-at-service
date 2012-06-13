module SessionsHelper
  include ApplicationHelper

  def web_auth
    # deny_access unless current_user_is_admin?
    
    return if Rails.env.test? #make testing easier
    puts 'test'
    authenticate_or_request_with_http_basic do |username, password|
      username == "stoned" && password == "whosyourdaddy"
    end
  end
end