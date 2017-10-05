class VideoJob < ApplicationJob
  queue_as :default

  def perform(count)
   videos = Yt::Collections::Videos.new
   @vid = videos.where(order: 'viewCount', q: 'dota2stream').take(count).last
   asd asd -asdasd asd
   @id = @vid.id 
   @duration = @vid.duration/2 
   $redis.set("vid_id", @id)
   $redis.set("vid_duration", @duration)
  end
end
