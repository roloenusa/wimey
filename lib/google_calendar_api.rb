class GoogleCalendarApi
  
  def initialize(token, library = 'calendar')
    @client = Google::APIClient.new
    @client.authorization.access_token = token
    
    @api = @client.discovered_api(library, 'v3')
  end
  
  def get_all_events(email)
    GoogleCalendarApi.execute_event(@client, email, @api.events.list)
  end

  def new_event(email, start_time, end_time, attendees, summary)
    body = {
     "start" => {"dateTime" => start_time.to_datetime.rfc3339},
     "end" => {"dateTime" => end_time.to_datetime.rfc3339},
     "attendees" => [{ "email" => attendees.join(',') }],
     # "description" => "This is a test",
     "summary" => summary
    }
    
    GoogleCalendarApi.execute_event(@client, email, @api.events.insert, body)
  end
  
  def self.execute_event(client, identifier, api, body = {})
    Rails.logger.error "Identifier: #{identifier}"
    event = {
      api_method: api,
      parameters: { "calendarId" => identifier },
      body: body.to_json,
      headers: {'Content-Type' => 'application/json'}
    }
    
    client.execute(event)
  end

end