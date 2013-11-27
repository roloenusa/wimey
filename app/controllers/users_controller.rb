class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :profile]
  
  def index
  end
  
  def show
    @calendar_url = calendar_user_tasks_path(user_id: @user.id)
  end
  
  def profile
    
  end
  
  def event
    google_api_token = session[:google_api_token]
    if google_api_token
      calendar = GoogleCalendarApi.new(google_api_token)
      calendar.new_event("roloenusa@gmail.com", Time.now, Time.now + 1.hour, ["jdelgado@quarkgames.com"], "This is a test")
    end
    
    redirect_to user_path(current_user)
  end
  
  private
  
    def set_user
      user_id = params[:id].to_i
      if current_user && current_user.id == user_id
        @user = current_user 
      else
        @user = User.find_by_id(user_id)
      end
      return @user 
    end
end
