class FriendsController < ApplicationController

  def list
    @friends = current_user.friends
  end

  def search
    @friend = params[:friends]
    render json: @friend
  end


  def search
    if params[:friends].present?
      @friend = params[:friends]
      # @friend = User.where(first_name: params[:friends])
      if @friend
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