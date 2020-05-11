class FriendsController < ApplicationController

  def list
    @friends = current_user.friends
  end

  def search
    if params[:friends].present?
      @friends = User.search(params[:friends])
      if @friends
        respond_to do |format|
          format.js { render partial: 'friends/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'friends/result' }
        end
      end    
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'friends/result' }
      end
    end
  end

end