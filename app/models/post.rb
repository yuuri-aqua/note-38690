class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  belongs_to :category
  has_many :post_tag_relations
  has_many :tags, through: :post_tag_relations
  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

end
