module GoogleApi
  
  module Client
    
    attr_accessor :client
    
    def create(credentials, token)
      @client = Google::APIClient.new
      @client.authorization.client_id = ENV['GOOGLE_CLIENT_ID']
      @client.authorization.client_secret = ENV['GOOGLE_SECRET']
      @client.authorization.update_token!(credentials)
      
      @client.authorization.access_token = token
    end
    
    def execute_event(identifier, api, body = {}, parameters = {})
      event = {}
      event[:api_method] = api
      event[:parameters] = { "calendarId" => identifier }.merge(parameters)
      event[:body] = body.to_json if body.present?
      event[:headers] = {'Content-Type' => 'application/json'}

      result = @client.execute(event)
      return result
    end
  end
end