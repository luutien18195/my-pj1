class User < ApplicationRecord
  before_save {user_name.downcase!}
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

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

  scope :select_id_fullName_userName, ->{select :id, :full_name, :user_name}
  scope :order_created_at, ->{order :created_at}

  def feed
    following_ids = "SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
      OR user_id = :user_id", user_id: id)
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def current_user? user
    self == user
  end
end
