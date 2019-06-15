class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :blog, optional: true
  has_one :notify, as: :notifyable

  attr_accessor :user,:blog
  before_save :ensure_user_and_blog

  def ensure_user_and_blog
    self.user_id = user
    self.blog_id = blog
  end

  def self.mycount(id)
    Comment.where("blog_id=?",id).count
  end
end
