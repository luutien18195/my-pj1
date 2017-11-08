class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    load_user
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t "notification.success"
      redirect_to @user
    else
      flash[:warning] = t "notification.failed"
      render :new
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:warning] = t "notification.can_not_find_user"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :full_name,
     :user_name, :password, :password_confirmation
  end
end
