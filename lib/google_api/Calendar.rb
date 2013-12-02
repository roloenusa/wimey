require 'google_api/client'

module GoogleApi
  
  class Calendar 
    include GoogleApi::Client
    
    def initialize(credentials, token)
      create(credentials, token)
    end
    
    def api
      @api ||= client.discovered_api('calendar', 'v3')
    end

    def get_all_events(email)
      execute_event(email, api.events.list)
    end

    def new_event(email, start_time, end_time, attendees, summary)
      body = {}
      body[:start] = {"dateTime" => start_time.to_datetime.rfc3339}
      body[:end] = {"dateTime" => end_time.to_datetime.rfc3339}
      body[:attendees] = [{ "email" => attendees.join(',') }] if attendees.present?
      body[:summary] = summary
    
      execute_event(email, api.events.insert, body)
    end
  
    def delete_event(email, event_id)
      parameters = {'eventId' => event_id}
                            
      execute_event(email, api.events.delete, {}, parameters)
    end
  end
end