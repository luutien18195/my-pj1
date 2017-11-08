class User < ApplicationRecord
  before_save {user_name.downcase!}
  validates :full_name, presence: true,
    length: {maximum: Settings.user.max_length_full_name}

  VALID_USER_NAME = /\A[\w+\-.]+[a-z\d\-.]+\z/i
  validates :user_name, presence: true,
    length: {maximum: Settings.user.max_length_user_name},
    format: {with: VALID_USER_NAME},
    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.user.min_length_password,
    maximum: Settings.user.max_length_password}

end
