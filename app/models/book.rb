class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  has_many :favorited_users, through: :favorites, source: :user

  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :tag,presence:true

  has_many :view_counts, dependent: :destroy

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_two_day_ago, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_three_day_ago, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_four_day_ago, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_five_day_ago, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_six_day_ago, -> { where(created_at: 6.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }






  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end


  def self.search(search_word)
    Book.where(['tag LIKE ?', "#{search_word}"])
  end



end
