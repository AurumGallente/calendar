json.array!(@events) do |event|
  json.extract! event, :id, :name, :eventdate, :user_id
  json.url event_url(event, format: :json)
end
