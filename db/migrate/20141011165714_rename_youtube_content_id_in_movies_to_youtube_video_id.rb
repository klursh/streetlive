class RenameYoutubeContentIdInMoviesToYoutubeVideoId < ActiveRecord::Migration
  def change
    rename_column :movies, :youtube_content_id, :youtube_video_id
  end
end
