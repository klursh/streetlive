class RemoveGoogleSecretTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :google_secret_token
  end
end
