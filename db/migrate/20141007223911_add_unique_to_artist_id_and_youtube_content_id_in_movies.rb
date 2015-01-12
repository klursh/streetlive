class AddUniqueToArtistIdAndYoutubeContentIdInMovies < ActiveRecord::Migration
  def change
    add_index :movies, [:artist_id, :youtube_content_id], unique: true
  end
end
