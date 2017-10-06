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
end
