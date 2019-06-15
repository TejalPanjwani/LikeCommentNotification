class HomeController < ApplicationController
  def index
    @blogs = Blog.all
    respond_to do |format|
      format.html
      format.csv { send_data @blogs.to_csv, filename: "blogs-#{Date.today}.csv" }
    end  
  end

  def new
    @blogs = Blog.all
  end

  def import_file
    Blog.import(params[:blog][:import])
    redirect_to root_path
  end 
end
