class FriendsController < ApplicationController

  def list
    @friends = current_user.friends
  end

end