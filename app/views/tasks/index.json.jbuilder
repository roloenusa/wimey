json.array!(@tasks) do |task|
  json.extract! task, :created_by, :user_id, :title, :description, :start_date, :end_date, :status
  json.url task_url(task, format: :json)
end
