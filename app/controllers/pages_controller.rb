class PagesController < ApplicationController

  def home
    # Testing Ahoy Vists
    ahoy.track_visit
    ahoy.track "btn-keep", title: "Keep playing"
    @total_visits = Visit.all.count
    @total_keeps = Ahoy::Event.distinct.count('visit_id')

    # For chat 
    @messages = Message.all

    #  For video 
    video_params 
    @video = Video.last

  end

  def update_video
    video_params
  	json_content = {data: @params}
  	render json: json_content
  end

  def video_params 
      @params = [] 
      @params << Video.last.vid_id 
      @params << Video.last.vid_duration 
      @params << Video.last.channel_title
      @params << Video.last.channel_id
      return @params 
  end 

  private

  def keep?(total_keeps,total_visits)
    (total_keeps / total_visits.to_f) * 100 > 50 ? true : false
  end

end