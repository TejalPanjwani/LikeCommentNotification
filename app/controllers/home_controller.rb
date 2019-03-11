class HomeController < ApplicationController
  def index
    @blogs = Blog.all  
  end

  def new
    @blogs = Blog.all
  end
end
