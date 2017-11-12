module UsersHelper
  def gravatar_for user, size: Settings.user.avatar_size, radius: ""
    gravatar_id = Digest::MD5::hexdigest(user.user_name.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.full_name, class: "gravatar", class: radius
  end

  def relationship
    current_user.active_relationships.build
  end

  def relationship_unfollow
    current_user.active_relationships.find_by followed_id: @user.id
  end
end
