class Blog < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  attr_accessor :user
  #before_save :ensure_user

  
  def ensure_user(user)
    self.user_id = user
  end

  def user_name(user_id)
    User.find(user_id).fullname
  end

  def check_user_like_or_not(user_id,blog)
    if Like.exists?(:user_id=>user_id) 

      if blog == Like.find_by("user_id=?",user_id).blog_id
        true
      else 
        false
      end
    else
      false
    end
      

  end
end

