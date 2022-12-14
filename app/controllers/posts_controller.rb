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
      redirect_to new_post_path
    else
      render :new
    end

  end


  def edit
    # @postから情報をハッシュとして取り出し、@post_formとしてインスタンス生成する
    post_attributes = @post.attributes
    @post_form = PostForm.new(post_attributes)
    @post_form.tag_name = @post.tags.first&.tag_name
  end

  def update
    # paramsの内容を反映したインスタンスを生成する
    @post_form = PostForm.new(post_form_params)

    # 画像を選択し直していない場合は、既存の画像をセットする
    @post_form.image ||= @post.image.blob

    if @post_form.valid?
      @post_form.update(post_form_params, @post)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def post_form_params
    params.require(:post_form).permit(:title, :text, :image, :category_id, tag_name:[]).merge(user_id: current_user.id)
  end

end
