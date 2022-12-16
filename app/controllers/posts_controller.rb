class  PostsController < ApplicationController

  def index
    @user = current_user
    @posts = @user.posts.order(id: "DESC")
  end

  def new
    @user = current_user
    @posts = @user.posts.order(id: "DESC")
    @post_form = PostForm.new
  end


  def create
    @post_form = PostForm.new(post_form_params)
    tag_list = params[:post_form][:tag_name].split(',')
    if @post_form.valid?
      @post_form.save(tag_list)
      redirect_to posts_path
    else
      @user = current_user
      @posts = @user.posts.order(id: "DESC")
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


  private

  def post_form_params
    params.require(:post_form).permit(:title, :text, :category_id, :tag_name, {images: []}).merge(user_id: current_user.id)
  end

end
