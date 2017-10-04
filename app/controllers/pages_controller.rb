class PagesController < ApplicationController

  def home
  	count = 130 
  	y = [0..10]
  	y.each do |i|
  		VideoJob.perform_now(count)
  		count -= 1 
  	end 
  end
end
