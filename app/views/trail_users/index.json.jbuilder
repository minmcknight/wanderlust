json.array!(@trail_users) do |trail_user|
  json.extract! trail_user, :id
  json.url trail_user_url(trail_user, format: :json)
end
