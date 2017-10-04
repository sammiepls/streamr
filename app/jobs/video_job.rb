class VideoJob < ApplicationJob
  queue_as :default

  def perform(count)
   videos = Yt::Collections::Videos.new
   @vid = videos.where(order: 'viewCount', q: 'dota2stream').take(count).last.id 
   $redis.set("test_key", @vid)
  end
end
