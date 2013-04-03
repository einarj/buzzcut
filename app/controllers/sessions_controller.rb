class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    @user.oauth_token = params[:oauth_token]
    @user.oauth_token_secret = params[:oauth_token_secret]
    debugger
    session[:remember_token] = @user.id
    session[:oauth_token] = @user.oauth_token
    session[:oauth_token_secret] = @user.oauth_token_secret
    #current_user = @user
    redirect_to '/feeds'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
