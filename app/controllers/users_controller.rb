class UsersController < ApplicationController

  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end
end
