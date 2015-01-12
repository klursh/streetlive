class Movie < ActiveRecord::Base
  belongs_to :artist

  validates :artist,             presence: true
  validates :title,              presence: true
  validates :view_count, presence: true,
                       numericality: { greater_than_or_equal_to: 0 }
  validates :youtube_video_id, presence: true,
                             uniqueness: { scope: :artist_id }

end
