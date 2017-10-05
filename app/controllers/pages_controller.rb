class PagesController < ApplicationController

  def home
  	count = 130 
  	@videos = video(count)
  	# byebug 
  end

  def update_video
  	count = rand(80..130)
  	@videos = video(count)
  	# byebug 
  	# p "run================================="
  	# respond_to do |format|
  	# 	format.js
  	# end
  	json_content = {data: @params}
  	render json: json_content
  end 

  def video(count)
  	@params = [] 
	VideoJob.perform_later(count)
	# byebug 
 	@params << $redis.get("vid_id")
 	@params << $redis.get("vid_duration")
 	@params << $redis.get("vid_title")
 	@params << $redis.get("vid_copy")
 	return @params 
  end 
end
