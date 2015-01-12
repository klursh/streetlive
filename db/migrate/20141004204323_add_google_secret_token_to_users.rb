class AddGoogleSecretTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_secret_token, :string
  end
end
