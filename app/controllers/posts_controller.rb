class PostsController < ApplicationController

  def index
    @posts = current_user.newsfeed
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_post_path(@post)
    else
      render :new
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "Post successfully updated"
      redirect_to user_post_path(@post)
    else
      flash.now[:alert] = "Could not update post"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
