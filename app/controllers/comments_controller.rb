class CommentsController < ApplicationController

    def create
        #add into db

        @comment = Comment.new(comments_params.merge(:user=>current_user.id,:blog=>params[:blog_id]))
        if @comment.save
            #go on show page
            #render 'blog/showBlog'
            @user = User.find(Blog.find(params[:blog_id]).user_id)
            if @user.id != current_user.id
                #@notice = Notify.new(:user => @user.id, notifyable: @comment)
                @notice = Notify.new(notifyable: @comment)

                @notice.ensure_user_and_notyfication(@user.id)
                if @notice.save
                    redirect_to showBlog_path(@comment.blog_id)
                end
            else 
                redirect_to showBlog_path(@comment.blog_id)
            end
        else
            #render 'blog/showBlog'
            redirect_to showBlog_path(params[:blog_id])
        end
    end

    def seeNotification
        #show all notification
        #read and unread notification
        @notices = Notify.where("user_id=?",current_user.id)
    end

    def showNotify
        @blog = Blog.find(params[:blog_id])
        @notifies = Notify.find(params[:comment_id])

        if @notifies.notifyable_type == "Comment"
            @comment = Comment.find(@notifies.notifyable_id)
            @notify = Notify.find(params[:comment_id])
            @notify.statustype = "read"
            @notify.save
        else
            @comment = Like.find(@notifies.notifyable_id)
            @notify = Notify.find(params[:comment_id])
            @notify.statustype = "read"
            @notify.save
        end
    end

    private
    def comments_params
        params.require(:comments).permit(:body)
    end
    
end
