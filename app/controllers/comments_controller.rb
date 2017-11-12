class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy
  before_action :find_post

  def index
    @comment = Comment.all
  end

  def create
    @comment = @post.comments.build comment_params
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      flash[:success] = t "notification.success_added"
    else
      flash[:warning] = t "notification.failed"
    end

    redirect_to root_url
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "notification.comment_deleted"
    else
      flash[:warning] = t "notification.can_not_delete"
    end

    redirect_to root_url
  end

  private

  def comment_params
    params.require(:comment).permit :content, :user_id
  end

  def find_post
    @post = Post.find_by id: params[:post_id]
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url unless @comment
  end
end
