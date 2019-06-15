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
      Like.where("user_id=?",user_id).each do |like|
        if blog == like.blog_id
          true
        else
          false
        end 
      end 
    else
      false
    end
  end

  def self.to_csv
    attributes = %w{title description}

    CSV.generate(headers: true) do |csv|
      csv << attributes #create rows

      all.each do |blog|
        csv << attributes.map{ |attr| blog.send(attr) }#map return array of value
        #here blog.send(attr) take value of particuler field
        #csv << blog.attributes.values_at(*attributes) #take values of attributes in array
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path,headers: true) do |row|
      Blog.create row.to_hash
    end
  end 
end

