class VideoJob < ApplicationJob
  queue_as :default

  def perform(count)
   videos = Yt::Collections::Videos.new
   @vid = videos.where(order: 'viewCount', q: 'dota2stream').take(count).last
   # asdasd -asdasd 
   @id = @vid.id 
   @duration = @vid.duration/2 
   @title = @vid.title
   @copyright = @vid.infringes_copyright? 

   Video.update(vid_id: @id, vid_duration: @duration, vid_title: @title, vid_copy: @copyright)
   $redis.set("vid_id", @id)
   $redis.set("vid_duration", @duration)
   $redis.set("vid_title", @title)
   $redis.set("vid_copy", @copyright)
  end
end
