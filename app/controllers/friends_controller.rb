class FriendsController < ApplicationController

  def list
    @friends = current_user.friends
  end

  def search
    @friend = params[:friends]
    render json: @friend
  end

end