class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(session[:remember_token])
  end

  def oauth_token
    session[:oauth_token]
  end

  def oauth_token_secret
    session[:oauth_token_secret]
  end
end
