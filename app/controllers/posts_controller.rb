class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      @posts = Post.all
    end
  
    def show
        Rails.logger.debug "Received request for post with ID: #{params[:id]}"
        # debugger
      @post = Post.find(params[:id])
      @comment = Comment.new
    end
  
    def new
      @post = Post.new
    end
  
    def create
      
      @post = current_user.posts.build(post_params)
  
      if @post.save
         @post.image.attach(post_params[:image]) # Attach the uploaded image
         notify_superadmin(@post) # Send email notification
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end
  
    # ... other actions ...
  
    private
  
    def post_params
      params.require(:post).permit(:title, :content, :image)
    end
  
    def notify_superadmin(post)
        superadmin = User.find_by(superadmin: true)
    
        PostMailer.new_post_notification(post, superadmin).deliver_now if superadmin
      end
  end
  