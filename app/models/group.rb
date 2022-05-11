class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :image

  def get_image(width,height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end
