class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == Settings.user.remember ? remember(@user) : forget(@user)
      redirect_after_login
    else
      flash.now[:danger] = t "sessions.create.login_error"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
  end

  def redirect_after_login
    if @user.admin
      redirect_to admin_root_path
    else
      redirect_back_or @user
    end
  end
end
