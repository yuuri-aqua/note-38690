class  PostsController < ApplicationController

  def index
    @user = current_user
    @posts = @user.posts.order(id: "DESC")
  end


  def new
    @user = current_user
    @post_form = PostForm.new
    @posts = @user.posts.order(id: "DESC")
  end


  def create
    @post_form = PostForm.new(post_form_params)
    tag_list = params[:post_form][:tag_name].split(',')
    if @post_form.valid?
      @post_form.save(tag_list)
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def post_form_params
    params.require(:post_form).permit(:title, :text, :image, :category_id, :tag_name).merge(user_id: current_user.id)
  end

end
