class FriendshipsController < ApplicationController

  def index
    @friends = current_user.friends
  end

  def create
    user = User.find(params[:friend])
    @friendship = current_user.friendships.new(friend: user)
    if @friendship.save
      redirect_to user_friendships_path
    end  
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update_attributes(friendship_params)
    redirect_to notifications_path
  end

  def notifications
    @friendships = decorated_pending_friends
    render :notifications
  end

  private

  def decorated_pending_friends
    Friendship.pending_requests(current_user).map do |friend|
      FriendshipDecorator.new(friend)
    end
  end

  def friendship_params
    params.require(:friendship).permit(:user, :friend, :accepted)
  end
end
