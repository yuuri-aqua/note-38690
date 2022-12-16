class PostForm
  include ActiveModel::Model

  attr_accessor :title, :text, :images, :user_id, :category_id, :tag_name

  with_options presence: true do
    validates :text
    validates :category_id
    validates :user_id
  end

  delegate :persisted?, to: :post

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end

  def save(tag_list)
    post = Post.create(title: title, text: text, images: images, user_id: user_id, category_id: category_id)
    
    tag_list.each do |tag_name|
      tag = Tag.where(tag_name: tag_name).first_or_initialize
      tag.save
      PostTagRelation.create(post_id: post.id, tag_id: tag.id)
    end
  end


  private

  attr_reader :post, :tag

  def default_attributes
    {
      title: @post.title,
      text: @post.text,
      images: @post.images,
      category_id: @post.category_id,
      tag_name: @post.tags.pluck(:tag_name).join(',')
    }
  end
end