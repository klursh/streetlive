class AddArtistToMessages < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.references :artist, index: true, null: false
    end
  end
end
