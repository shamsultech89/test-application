json.extract! github_user, :id, :name, :github_id, :avatar_url, :created_at, :updated_at
json.url github_user_url(github_user, format: :json)
