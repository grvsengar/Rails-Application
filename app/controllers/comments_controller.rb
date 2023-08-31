class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        redirect_to @post, notice: 'Comment was successfully created.'
      else
        render 'posts/show'
      end
    end
  
    def edit
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
    end
  
    def update
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
  
      if @comment.update(comment_params)
        redirect_to @post, notice: 'Comment was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      redirect_to @post, notice: 'Comment was successfully destroyed.'
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content, :image)
    end
  end
  