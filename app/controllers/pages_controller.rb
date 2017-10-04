class PagesController < ApplicationController

  def home
  	count = 130 
  	y = [0..10]
  	y.each do |i|
  		VideoJob.perform_now(count)
  		count -= 1 
  	end

  	categories =  $redis.get("categories")
    if categories.nil?
      categories = Category.all.to_json
      $redis.set("categories", categories)
    end
  	     
  end
end
