class PagesController < ApplicationController
	
  def home
  	count = 130 
  	y = [0..10]
  	y.each do |i|
  		VideoJob.perform_in(y.minutes, count)
  		count -= 1 
  	end 
  end
end
