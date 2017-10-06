class VideoJob < ApplicationJob
  queue_as :default

  def perform
   count = rand(80..130)
   videos = Yt::Collections::Videos.new
   @vid = videos.where(order: 'viewCount', q: 'dota2stream').take(count).last
   byebug 
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
