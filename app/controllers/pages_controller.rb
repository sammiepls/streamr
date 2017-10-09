class PagesController < ApplicationController

  def home
    # Testing Ahoy Vists
    ahoy.track_visit
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

  def voting
    @total_keeps = Ahoy::Event.distinct.count('visit_id')
    json_content = {data: @total_keeps}
  	render json: json_content
  end

  def update_video
    # byebug
    ahoy.track_visit
  	@params = []
  	@params << Video.last.vid_id
  	@params << Video.last.vid_duration
    @params << Video.last.channel_title
    @params << Video.last.channel_id
    @params << Visit.all.count
    @params << Ahoy::Event.distinct.count('visit_id')
    @params << Video.last
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
