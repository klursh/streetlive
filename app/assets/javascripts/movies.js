/*global $ */
$(function() {
    var ready = function() {
        $('.movies.new,.movies.create,.movies.edit,.movies.update').ready(function() {
            var $videoId = $('#movie_youtube_video_id');
            if ($videoId.val() !== '') {
                showVideo($videoId.val());
            }
        });
        $('.movies.new,.movies.create').ready(function() {
            var $videoId = $('#movie_youtube_video_id');
            if ($videoId.val() !== '') {
                $('#new-movie-form-area').removeClass('hidden');
                $videoId.parent().removeClass('hidden');
            }

            $.ajax({
                url: '/youtube/uploads',
                type: 'GET',
                dataType: 'json',
                success: function(playlistItemsList) {
                    // see: Youtube Data API Reference - https://developers.google.com/youtube/v3/docs/playlistItems/list?hl=ja
                    displayYoutubeVideos(playlistItemsList.items);
                },
            });

            $(document).on('click', '.new-movie-youtube-video', function() {
                setFormWithVideo.call(null, this);
            });

            function displayYoutubeVideos(playlistItems) {
                var $videoArea = $('#new-movie-youtube-videos');
                $videoArea.empty();
                $.each(playlistItems, function(i, item) {
                    appendVideoItem(item);
                });
                if ($videoArea.children().size() === 0) {
                    $('<p>').html('<a href="http://youtube.com">YouTube</a>に動画をアップロードしてください。')
                        .attr('id', 'new-movie-youtube-load-failed')
                        .appendTo($videoArea);
                }
            }

            function appendVideoItem(item) {
                var $video = $('<div class="new-movie-youtube-video clearfix">').append(
                    $('<img class="pull-left" width="120" height="90">').attr('src', item.snippet.thumbnails.default.url)
                ).append(
                    $('<div class="title">').text(item.snippet.title)
                ).append(
                    $('<div class="published-at">').text(item.snippet.publishedAt.split('T')[0])
                ).attr({
                    'data-video-id': item.snippet.resourceId.videoId,
                    'data-title': item.snippet.title,
                    'data-description': item.snippet.description
                });
                $('#new-movie-youtube-videos').append($video);
            }

            function setFormWithVideo(youtubeVideoElement) {
                var e = youtubeVideoElement;
                showVideo(e.dataset.videoId);
                $('#movie_youtube_video_id').val(e.dataset.videoId);
                $('#movie_title').val(e.dataset.title);
                $('#movie_description').val(e.dataset.description);
                $('#new-movie-form-area').removeClass('hidden');
                // エラー項目があったらエラーを消す
                $('#new_movie .form-group.has-error')
                    .removeClass('has-error')
                    .children('.help-block').remove();
            }
        });
    };
    function showVideo(youtubeVideoId) {
        $('#movie-youtube-video-area').empty().append(
            $('<iframe width="540" height="330" frameborder="0" allowfullscreen>')
                .attr('src', 'http://www.youtube.com/embed/' + youtubeVideoId + '?rel=0')
        );
    }

    ready();
    $(document).on('page:load', ready);
});
