class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #has_many :blogs
  devise :database_authenticatable, :registerable,
         :validatable
      
      
 #  authentication_keys: [:fullname] ==> when login with fullname than write 
end
