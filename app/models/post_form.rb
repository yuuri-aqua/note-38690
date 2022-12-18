class PostForm
  include ActiveModel::Model

  attr_accessor :title, :text, :images, :user_id, :post_id, :category_id, :tag_name

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
    tag_list.each do |new_tag|
      post_tag = Tag.find_or_create_by(tag_name: new_tag)
      post.tags << post_tag
    end
  end

  def update(tag_list)
    ActiveRecord::Base.transaction do
      # @deli = Deli.where(id: deli_id)
      @post.update(title: title, text: text, images: images, user_id: user_id, category_id: category_id)
      current_tags = @post.tags.pluck(:tag_name) unless @post.tags.nil?
      old_tags = current_tags - tag_list
      new_tags = tag_list - current_tags

      old_tags.each do |old_name|
        @post.tags.delete Tag.find_by(tag_name: old_name)
      end

      new_tags.each do |new_name|
        post_tag = Tag.find_or_create_by(tag_name: new_name)
        @post.tags << post_tag
        post_tag_relation = PostTagRelation.where(post_id: @post.id, tag_id: post_tag.id).first_or_initialize
        post_tag_relation.update(post_id: @post.id, tag_id: post_tag.id)
      end
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
