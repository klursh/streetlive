class RenameMusicsToMovies < ActiveRecord::Migration
  def change
    rename_table :musics, :movies
  end
end
