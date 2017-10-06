class VideoJob < ApplicationJob
  queue_as :default

  def perform(count)
   count = rand(80..130)
   videos = Yt::Collections::Videos.new
   @vid = videos.where(order: 'viewCount', q: 'dota2stream').take(count).last
   @id = @vid.id 
   @duration = @vid.duration/2 
   @title = @vid.title
   @copyright = @vid.infringes_copyright? 
   Video.update(vid_id: @id, vid_duration: @duration, vid_title: @title, vid_copy: @copyright)
   VideoJob.set(wait: 1.minutes).perform_later(count)
  end
end
