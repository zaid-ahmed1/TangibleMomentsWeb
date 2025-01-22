json.extract! memory, :id, :title, :video, :created_at, :updated_at
json.url memory_url(memory, format: :json)
json.video url_for(memory.video)
