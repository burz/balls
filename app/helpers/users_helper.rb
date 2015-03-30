module UsersHelper
  def user_acronym user
    user.split(' ').inject '' do |str, word|
      str = str + word[0]
    end
  end
end
