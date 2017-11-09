class Post < ApplicationRecord
  belongs_to :user
  default_scope ->{order(created_at: :desc)}

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:
    Settings.user.max_length_content}

end
