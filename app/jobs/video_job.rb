class VideoJob < ApplicationJob
  queue_as :default

  def perform
  live = rand(0..1)
  videos = Yt::Collections::Videos.new

  if live == 1 
   vid = videos.where(order: 'viewCount', q: 'fun streaming dota', videoEmbeddable: true)
   max = vid.count
   # byebug 
   count = rand(80..max)
   @live = vid.take(count).last 
   video(@live)
   Video.last.update(vid_id: @details[0] , vid_duration: @details[1],
    vid_title: @details[2], channel_title: @details[3], 
    channel_id: @details[4], video_type: 'prev')
   else 
    vid = videos.where(order: 'viewCount', q: 'dota 2 live stream', event_type: 'live', videoEmbeddable: true)
    max = vid.count
    # byebug 
    count = rand(0..max)
    @live = vid.take(count).last
    video(@live)
    Video.last.update(vid_id: @details[0] , vid_duration: @details[1],
        vid_title: @details[2], channel_title: @details[3], 
        channel_id: @details[4], video_type: 'live')
 end 
   CleanVisitsEventsJob.perform_now
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
