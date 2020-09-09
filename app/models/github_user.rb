class GithubUser < ApplicationRecord
  validates :github_id, uniqueness: true
end
