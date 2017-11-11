class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum:
    Settings.user.max_length_content }
  validates :content, presence: true, length: {maximum:
    Settings.user.max_length_content}

  scope :order_by_created_at_desc, ->{order created_at: :desc}
end
