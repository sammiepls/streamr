class PagesController < ApplicationController

  def home
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
  	json_content = {data: @params}
  	render json: json_content
  end 


end