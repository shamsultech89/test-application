class CreateGithubUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :github_users do |t|
      t.string :name
      t.integer :github_id
      t.string :avatar_url

      t.timestamps
    end
  end
end
