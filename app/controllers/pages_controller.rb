class PagesController < ApplicationController

  def home
    # Testing Ahoy Vists
    ahoy.track_visit
    ahoy.track "btn-keep", title: "Keep playing"
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

 	return @params
  end
end
