class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all.order("updated_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Object successfully created"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

 def logged_in_user
            unless logged_in?
            store_location
            flash[:danger] = "Please log in!"
            redirect_to login_path
            end
        end
        
        # Confirms the correct user
        def correct_user
            @post = Post.find(params[:id])
            user = @post.user
            redirect_to(root_url) unless (current_user?(user) || current_user.admin?)
        end


end
