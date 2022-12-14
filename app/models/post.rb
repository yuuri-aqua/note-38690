class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :category, optional: true
  has_many :post_tag_relations
  has_many :tags, through: :post_tag_relations
end
