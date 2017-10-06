class PagesController < ApplicationController

  def home
    @messages = Message.all
    # Video.create(vid_id: 'asd', vid_duration: 123123, vid_title: 'asdasd', vid_copy: 'false')
  	@params = []
  	@params << Video.last.vid_id
  	@params << Video.last.vid_duration
    @params << Video.last.channel_title
    @params << Video.last.channel_id
  end

  def update_video
    # video
  	@params = []
  	@params << Video.last.vid_id
  	@params << Video.last.vid_duration
    @params << Video.last.channel_title
    @params << Video.last.channel_id
  	# byebug
  	# p "run================================="
  	# respond_to do |format|
  	# 	format.js
  	# end
  	json_content = {data: @params}
  	render json: json_content
  end
  	# @params = []
  	# @params << Video.last.vid_id
  	# @params << Video.last.vid_duration

  # def update_video
  	# @params = []
  	# @params << Video.last.vid_id
  	# @params << Video.last.vid_duration
  	# # byebug
  	# # p "run================================="
  	# # respond_to do |format|
  	# # 	format.js
  	# # end
  	# json_content = {data: @params}
  	# render json: json_content
  # end

  # def video
  #   count = rand(80..130)
  #   videos = Yt::Collections::Videos.new
  #   @vid = videos.where(order: 'viewCount', q: 'dota2stream').take(count).last
  #   @id = @vid.id
  #   @duration = @vid.duration/2
  #   @title = @vid.title
  #   @copyright = @vid.infringes_copyright?
  #   Video.update(vid_id: @id, vid_duration: @duration, vid_title: @title, vid_copy: @copyright)
  #   # VideoJob.set(wait: 1.minutes).perform_later(count)
  # end

end
