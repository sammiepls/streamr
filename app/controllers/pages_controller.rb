class PagesController < ApplicationController

  def home
  	count = 130 
  	y = (1..5).to_a
	count -= 1 
 	VideoJob.perform_now(count)
  	@videos = $redis.get("test_key")    
  end

  def update_video 
  end 
end
