class BlogsController < ApplicationController

    def seeBlog
        #see all bogs
        @blogs = Blog.all
    end

    def addBlog
        #display form of blog
        @blog = Blog.new
    end


    def showBlog
        @blog = Blog.find(params[:blog_id])
        @comments = Comment.where("blog_id=?",params[:blog_id] )
    end

    def myBlog
        @myBlogs = Blog.where("user_id=?",current_user.id)
    end

    def create
        #add blog into db

        @blog = Blog.new(blog_params.merge(:user=>current_user.id))
        #binding.pry
        @blog.ensure_user(current_user.id)
        if @blog.save
            #go on show page
            flash[:success] = "Successfully blog added...!!!"
            redirect_to blog_path(@blog)

        else
            render 'addBlog'

        end
        
    end

    def edit
        if current_user
            if current_user.id == Blog.find(params[:id]).user_id
                @blog = Blog.find(params[:id])
            else 
                flash[:danger] = " you only edit your blogs!!!"
                redirect_to seeBlog_path
            end
         
        else
            redirect_to new_user_session_path
        end

    end

    def update
        @blog = Blog.find(params[:id])
        if @blog.update(blog_update_params)
            flash[:success] = "Successfully blog updated!!!"
            redirect_to blog_path(@blog)
        else
        render 'edit'
        end
    end

    def show
        @blog = Blog.find(params[:id])
        @comments = Comment.where("blog_id=?",params[:blog_id] )
    end

    def addLike
        @like = Like.new(:user=>current_user.id, :blog=>params[:blog_id])
        if @like.save
            
            @user = User.find(Blog.find(params[:blog_id]).user_id)
            if @user.id != current_user.id
                @notice = Notify.new(notifyable: @like)
                    
                @notice.ensure_user_and_notyfication(@user.id)
                if @notice.save
                    flash[:success] = "You like this post"
                    redirect_to showBlog_path(params[:blog_id])
                end
            else
                flash[:success] = "You like this post"
                redirect_to showBlog_path(@like.blog_id)
            end
        else 
            redirect_to showBlog_path(params[:blog_id])
        end
    end

    def destroyLike
        @like = Like.find_by("blog_id=?",params[:blog_id])
        @notice = Notify.find_by("notifyable_id=?",@like.id)
        if @notice
            @notice = Notify.find_by("notifyable_id=?",@like.id)
            @notice.destroy
        
            @like.destroy
        else
            @like.destroy
        end
        flash[:danger] = "You dislike this post"
        redirect_to showBlog_path(params[:blog_id])
    end

    private
    def blog_params
        params.require(:blogs).permit(:title,:description)
    end

    def blog_update_params
        params.require(:blog).permit(:title,:description)
    end

end
