json.array!(@projects) do |project|
  json.extract! project, :created_by, :title, :description, :status
  json.url project_url(project, format: :json)
end
