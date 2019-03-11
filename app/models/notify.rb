class Notify < ApplicationRecord
  belongs_to :user,  optional: true
  belongs_to :notifyable, polymorphic: true
  enum statustype: [:unread,:read]
  #attr_accessor :user

  #before_save :ensure_user_and_notyfication, on: :create

  def ensure_user_and_notyfication(user)
    self.user_id = user
  end


  def notify_to_user(id)
    Blog.find_by("user_id=?",id)
  end

  def  name_of_user(id,nametable) 
    if nametable == "Comment"
      User.find(Comment.find(id).user_id).fullname
    else 
      User.find(Like.find(id).user_id).fullname
    end

  end

  def self.mycount(id)
    Notify.where("user_id=?",id).where("statustype=?",0).count

  end
  
end
