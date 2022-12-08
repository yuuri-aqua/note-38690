class  PostsController < ApplicationController
  def index
    @user = current_user
    @posts = @user.posts
  end

  def create
    @post = Post.create(post_params)
  end

  private
  def post_params
    params.permit(:title, :text, :image).merge(user_id: current_user.id)
  end
end
