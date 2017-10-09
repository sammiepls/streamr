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
      live = rand(0..1)
      videos = Yt::Collections::Videos.new

      if live == 1 
       luck = rand(0..1)
          if luck == 1 
            vid = videos.where(order: 'viewCount', q: 'fun streaming dota', videoEmbeddable: true, videoDuration: 'long')
            num = 70 
          else 
            vid = videos.where(order: 'viewCount', q: 'fun streaming dota', videoEmbeddable: true, videoDuration: 'medium')
            num = 40 
          end 
       max = vid.count
       count = rand(num..max)
       @live = vid.take(count).last 
       video(@live)
       Video.last.update(vid_id: @details[0] , vid_duration: @details[1],
        vid_title: @details[2], channel_title: @details[3], 
        channel_id: @details[4], video_type: 'prev')
       else 
        vid = videos.where(order: 'viewCount', q: 'dota 2 live stream', event_type: 'live', videoEmbeddable: true)
        max = vid.count
        count = rand(0..max)
        @live = vid.take(count).last
        video(@live)
        Video.last.update(vid_id: @details[0] , vid_duration: @details[1],
            vid_title: @details[2], channel_title: @details[3], 
            channel_id: @details[4], video_type: 'live')
     end 
       CleanVisitsEventsJob.perform_now
    end
  end

  def video(vid)
    @details = [] 
    @details << @live.id 
    @details << @live.duration/2
    @details << @live.title
    @details << @live.channel_title
    @details << @live.channel_id
    return @details 
  end 
end
