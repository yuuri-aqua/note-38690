class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = @user.posts.includes(:user).order("created_at DESC")
  end

  def new
    @user = current_user
    @posts = @user.posts.includes(:user).order("created_at DESC")
    @post_form = PostForm.new
  end

  def create
    @post_form = PostForm.new(post_form_params)
    tag_list = params[:post_form][:tag_name].split(',')
    if @post_form.valid?
      @post_form.save(tag_list)
      redirect_to new_post_path
    else
      @user = current_user
      @posts = @user.posts.order(id: 'DESC')
      render :new
    end
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
    @post_form = PostForm.new(post: @post)
  end

  def update
    @user = current_user
    @post = Post.find(params[:id])
    @post_form = PostForm.new(post_update_params, post: @post)
    tag_list = params[:post_form][:tag_name].split(',')
    if @post_form.valid?
      @post_form.update(tag_list)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    return unless @post.destroy

    redirect_to posts_path
  end

  private

  def post_form_params
    params.require(:post_form).permit(:title, :text, :category_id, :tag_name, { images: [] }).merge(user_id: current_user.id)
  end

  def post_update_params
    params.require(:post_form).permit(:title, :text, :category_id, :tag_name, { images: [] }).merge(user_id: current_user.id,
                                                                                                    post_id: params[:id])
  end
end
