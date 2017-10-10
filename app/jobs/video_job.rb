class VideoJob < ApplicationJob
  queue_as :default

  def perform
    visitor = Visit.all.count 

    if visitor != 0 
    likes = Ahoy::Event.all.count 
    more_than = (likes/visitor.to_f)*100

      if more_than >= 50 
        if Video.last.video_type != 'prev'
          VideoJob.disable!
          Video.last.update(video_type: 'prev')
        else 
          CleanVisitsEventsJob.perform_now
          play_random_video
        end 
      else 
        has_available_stream = false
        if Stream.count > 0
          play_stream(has_available_stream)
        else
         play_random_video
        end
      end 
    else 
      if Stream.count > 0
        play_stream(has_available_stream)
      else
       play_random_video
      end
    end 
  end 
  
    def play_stream(has_available_stream)
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
    end 

    def video(vid)
      @details = []
      @details << vid.id
      @details << vid.duration/2
      @details << vid.title
      @details << vid.channel_title
      @details << vid.channel_id
      Video.last.update(vid_id: @details[0] , vid_duration: @details[1],
          vid_title: @details[2], channel_title: @details[3],
          channel_id: @details[4], video_type: 'nil')
    end

    def play_random_video
        live = rand(0..1)
        videos = Yt::Collections::Videos.new

        if live == 1 
         luck = rand(0..1)
            if luck == 1 
              vid = videos.where(order: 'viewCount', q: 'fun streaming dota', videoEmbeddable: true, videoDuration: 'long')
              num = 50 
            else 
              vid = videos.where(order: 'viewCount', q: 'fun streaming dota', videoEmbeddable: true, videoDuration: 'medium')
              num = 30 
            end 
         max = vid.count
         count = rand(1..max)
         @live = vid.take(count).last 
         video(@live)
        else
          vid = videos.where(order: 'viewCount', q: 'dota 2 stream', event_type: 'live', videoEmbeddable: true)
          max = vid.count
          count = rand(1..max)
          @live = vid.take(count).last
          video(@live)
        end
      CleanVisitsEventsJob.perform_now
    end 
    

    def self.disable!
      # set a flag in Redis, it will expire after 10 minutes
      Sidekiq.redis {|c| c.set("disable_periodic_jobs", 1, ex: 60) }
    end

end
