class SetNotNullToEmailInArtists < ActiveRecord::Migration
  def change
    change_column :artists, :email, :string, null: false
  end
end
