class PagesController < ApplicationController

  def home
    # Testing Ahoy Vists
    ahoy.track_visit
    ahoy.track "btn-keep", title: "Keep playing"

  	# count = 130
  	# y = (1..5).to_a
  	# y.each do |i|
  	# 	VideoJob.perform_now(count)
  	# 	count -= 1
  	# end

  	# videos =  $redis.get("categories")
   #  if categories.nil?
   #    categories = Category.all.to_json
   #    $redis.set("categories", categories)
   #  end

  end
end
