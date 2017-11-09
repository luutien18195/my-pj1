class UsersController < ApplicationController
  before_action :load_user, except: %i(new create)
  before_action :logged_in_user, except: %i(show new create)

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t "notification.success"
      redirect_to @user
    else
      flash[:warning] = t "notification.failed"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "notification.success_updated"
      redirect_to @user
    else
      render :edit
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
