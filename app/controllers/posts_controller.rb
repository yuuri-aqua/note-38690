class  PostsController < ApplicationController

  def index
    @user = current_user
    @posts = @user.posts.order(id: "DESC")
  end


  def new
    @user = current_user
    @post = Post.new
    @posts = @user.posts.order(id: "DESC")
  end

  def create

    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :image, :category_id).merge(user_id: current_user.id)
  end

end
