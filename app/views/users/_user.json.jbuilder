json.extract! user, :id, :name

profile = user.profile
if profile
  json.profile do
    json.id profile.id
    json.address profile.address
    json.street profile.street
    json.city profile.city
    json.state profile.state
    json.country profile.country
    json.zipcode profile.zipcode
  end
end
json.url user_url(user, format: :json)