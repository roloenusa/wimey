class UsersController < ApplicationController
  def index
  end
  
  def show
    user_id = params[:id].to_i
    if current_user && current_user.id == user_id
      @user = current_user 
    else 
      @user = User.find_by_id(user_id)
    end
  end
  
  def profile
    user_id = params[:id].to_i
    if current_user && current_user.id == user_id
      @user = current_user 
    else 
      @user = User.find_by_id(user_id)
    end
  end
end
