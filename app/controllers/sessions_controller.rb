class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by user_name: params[:session][:user_name].downcase

    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url
    else
      flash[:danger] = t "notification.invalid_user"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
