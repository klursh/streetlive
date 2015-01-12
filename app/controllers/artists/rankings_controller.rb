class Artists::RankingsController < RankingsController

  def view
    @artists = Artist.order(view_count: :desc).limit(30)
  end

  def message
    count_messages = 'natural left join (select artist_id as id, count(*) as count_messages from messages group by artist_id) as subq'
    @artists = Artist.joins(count_messages).order('count_messages desc').limit(30)
  end
end
