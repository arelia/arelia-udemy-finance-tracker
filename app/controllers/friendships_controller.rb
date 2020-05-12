class FriendshipsController < ApplicationController

  def list
    @friends = current_user.friends
  end

  def search
    if params[:friends].present?
      @friends = User.search(params[:friends])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'friendships/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'friendships/result' }
        end
      end    
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'friendships/result' }
      end
    end
  end

  def create
    user = current_user
    friend = User.find(params[:friend])
    @friendship = Friendship.create(user: user, friend: friend)
      flash[:notice] = "You are now following #{friend.full_name}."
      redirect_to friends_path
  end

  def destroy
    friend = User.find(params[:id])
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "You have stopped following #{friend.full_name}."
    redirect_to friends_path
  end

end