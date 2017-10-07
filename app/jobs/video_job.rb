class VideoJob < ApplicationJob
  queue_as :default

  def perform
    has_available_stream = false
    if Stream.count > 0
      while !has_available_stream && Stream.count > 0 
        if Counter.first.nil?
          counter = Counter.new
          counter.save
        else
          counter = Counter.first
          if counter.current_index >= Stream.count
            counter.current_index = 0
            counter.save
          end
        end
        stream = Stream.all[counter.current_index]
        video = Yt::Video.new id: stream.stream_id
        #Stream in our database is no longer live
        if video.live_broadcast_content != 'live'
          stream.destroy
        else
          if Streaming.count == 0
            Streaming.new(stream_id: stream.stream_id, stream_title: stream.stream_title, 
            channel_id: stream.channel_id, channel_title: stream.channel_title, streamer: stream.streamer)
          else
          Streaming.last.update(stream_id: stream.stream_id, stream_title: stream.stream_title, 
            channel_id: stream.channel_id, channel_title: stream.channel_title, streamer: stream.streamer)
          end
          Video.last.update(vid_id: stream.stream_id, vid_title: stream.stream_title, 
            channel_id: stream.channel_id, vid_duration: 0)
          has_available_stream = true
          counter.current_index += 1
          counter.save
        end
      end
    else
      count = rand(80..130)
      videos = Yt::Collections::Videos.new
      @vid = videos.where(order: 'viewCount', q: 'dota2stream').take(count).last
      # byebug 
      @id = @vid.id 
      @duration = @vid.duration/2
      @title = @vid.title
      @copyright = @vid.infringes_copyright? 
      @channel_title = @vid.channel_title
      @channel_id = @vid.channel_id
      Video.last.update(vid_id: @id, vid_duration: @duration, 
      vid_title: @title, vid_copy: @copyright, channel_title: @channel_title, channel_id: @channel_id)
      # VideoJob.set(wait: 1.minutes).perform_later(count)
    end
  end
end
