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
    #take blog title
    if Notify.find_by("notifyable_id=?",id).notifyable_type == "Comment"
      Blog.find(Comment.find(id).blog_id).title
    else 
      Blog.find(Like.find(id).blog_id).title
    end
  end

  def take_user_id(user_id,notifyable_id)
    #take blog id
    if Notify.find_by("notifyable_id=?",notifyable_id).notifyable_type == "Comment"
      Comment.find(notifyable_id).blog_id
    else 
      Like.find(notifyable_id).blog_id
    end
  end

  def  name_of_user(id) 
    #take name of user who like and comment
    if Notify.find_by("notifyable_id=?",id).notifyable_type == "Comment"
      User.find(Comment.find(id).user_id).fullname
    else 
      User.find(Like.find(id).user_id).fullname
    end
  end

  def self.mycount(id)
    Notify.where("user_id=?",id).where("statustype=?",0).count
  end
  
end
