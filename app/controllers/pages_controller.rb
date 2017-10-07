class PagesController < ApplicationController

  def home
    # Testing Ahoy Vists
    ahoy.track_visit
    ahoy.track "btn-keep", title: "Keep playing"
    @total_visits = Visit.all.count
    @total_keeps = Ahoy::Event.distinct.count('visit_id')

    @messages = Message.all

    @params = []
  	@params << Video.last.vid_id
  	@params << Video.last.vid_duration
    @params << Video.last.channel_title
    @params << Video.last.channel_id
    @video = Video.last


  end

  def update_video
    # byebug 
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

  private

  def keep?(total_keeps,total_visits)
    (total_keeps / total_visits.to_f) * 100 > 50 ? true : false
  end

end