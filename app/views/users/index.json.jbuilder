json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :city, :state, :zipcode, :password_digest
  json.url user_url(user, format: :json)
end
