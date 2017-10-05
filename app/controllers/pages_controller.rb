class PagesController < ApplicationController

  def home
  	count = 130 
  	@videos = video(count)
  end

  def update_video
  	count = rand(80..130)
  	@videos = video(count)
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
 	@params << $redis.get("vid_id")
 	@params << $redis.get("vid_duration")

 	return @params 
  end 
end
