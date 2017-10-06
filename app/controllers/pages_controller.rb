class PagesController < ApplicationController

  def home
    @messages = Message.all
  end

  def update_video
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
  end

end
