class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user: current_user)
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find_by(post: @post, user: current_user)
    @like.destroy
    redirect_to @post
  end
end
