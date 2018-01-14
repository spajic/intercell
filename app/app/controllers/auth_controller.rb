class AuthController < ApplicationController
  before_action :redirect_logged_user_to_chat

  # show authorization form for unauthorized user
  def new
  end

  # Get username from params, save to session and redirect to chat window
  def create
    session[:username] = params[:username]
    redirect_to root_path
  end

  private

  def redirect_logged_user_to_chat
    redirect_to root_path if session[:username]
  end
end
