class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
      @comment = current_user.comments.build
      @feed_items = current_user.feed.order_by_created_at_desc
        .paginate page: params[:page]
    else
      @user = User.new
    end
  end

  def help; end

  def login; end

  def about; end

  def contact; end
end
