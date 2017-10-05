class PagesController < ApplicationController

  def home
  	count = rand(80..130)
  	if @params == nil 
  		@videos = video(count)
  	else 
  		@videos = video(count)
  		# byebug 
  		# p "run================================="
  		# respond_to do |format|
  		# 	format.js
  		# end
  		json_content = {data: @params}
  		render json: json_content
  	end 
  end

  # def update_video
  # 	count = rand(80..130)
  # 	@videos = video(count)
  # 	# byebug 
  # 	# p "run================================="
  # 	# respond_to do |format|
  # 	# 	format.js
  # 	# end
  # 	json_content = {data: @params}
  # 	render json: json_content
  # end 

  def video(count)
  	@params = [] 
	VideoJob.perform_later(count)
	# byebug 
 	@params << $redis.get("vid_id")
 	@params << $redis.get("vid_duration")

 	return @params 
  end 
end
