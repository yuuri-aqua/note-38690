class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :category

  validates :text, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end
  
end
