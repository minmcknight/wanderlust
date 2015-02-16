json.array!(@trails) do |trail|
  json.extract! trail, :id, :name, :url, :geocode, :comments
  json.url trail_url(trail, format: :json)
end
