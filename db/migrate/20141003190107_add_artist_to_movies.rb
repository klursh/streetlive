class AddArtistToMovies < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.references :artist, index: true, null: false
    end
  end
end
