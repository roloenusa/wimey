class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
	  # You need to implement the method below in your model (e.g. app/models/user.rb)
	  @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
	  
	  #What data comes back from OmniAuth?     
    @auth = request.env["omniauth.auth"]
    #Use the token from the data to request a list of calendars
    @token = @auth["credentials"]["token"]
    client = Google::APIClient.new
    client.authorization.access_token = @token
    calendar = client.discovered_api('calendar', 'v3')
    
    api_event_list = {
      :api_method => calendar.events.list,
      :parameters => {'calendarId' => 'roloenusa@gmail.com'},
      :headers => {'Content-Type' => 'application/json'}
    }
    
    api_event_insert = {
      api_method: calendar.events.insert,
      parameters: { "calendarId" => "roloenusa@gmail.com" },
      body: {
       "end" => {"dateTime" => "2013-11-27T10:00:00.000-07:00"},
       "start" => {"dateTime" => "2013-11-27T10:00:00.000-07:00"},
       "attendees" => [{ "email" => "jdelgado@quarkgames.com" }],
       "description" => "This is a test",
       "summary" => "Sent from the login api"
      }.to_json,
      headers: {'Content-Type' => 'application/json'}
    }
    
    @result = client.execute(api_event_insert)
      
    Rails.logger.error @auth.inspect
    Rails.logger.error @token
    Rails.logger.error JSON.parse @result.body

	  if @user.persisted?
	    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
	    sign_in_and_redirect @user, :event => :authentication
	  else
	    session["devise.google_data"] = request.env["omniauth.auth"]
	    redirect_to new_user_registration_url
	  end
  end
end