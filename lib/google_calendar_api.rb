module GoogleCalendarApi
  
  def get_all_events(email)
    execute_event(email, calendar.events.list)
  end

  def new_event(email, start_time, end_time, attendees, summary)
    body = {
     "end" => {"dateTime" => "2013-11-27T10:00:00.000-07:00"},
     "start" => {"dateTime" => "2013-11-27T10:00:00.000-07:00"},
     "attendees" => [{ "email" => "jdelgado@quarkgames.com" }],
     # "description" => "This is a test",
     "summary" => summary
    }
    
    execute_event(email, calendar.events.insert, body)
  end
  
  def execute_event(identifier, event, body = {})
    event = {
      api_method: event,
      parameter: { "calendarId" => identifier },
      body: body.to_json,
      headers: {'Content-Type' => 'application/json'}
    }
    
    client.execute(event)
  end

end