class StreamsController < ApplicationController
	def create
		account = Yt::Account.new access_token: current_user.oauth_token
		channel = account.channel
		live = channel.videos.where(type: 'video', eventType:'live').first
		if live.nil?
			redirect_to root_path, flash: { error: "Sorry, you don't have a live stream currently, please try again a few seconds later" }
		else
			if Stream.find_by(stream_id: live.id)
				redirect_to root_path, flash: { error: "Your stream is already in queue, please be patient" }
			else
				@stream = Stream.new(stream_id: live.id, stream_title: live.title, 
					channel_id: channel.id, channel_title: channel.title, streamer: account.name)
				if @stream.save
					redirect_to root_path, flash: { success: "Yay! Your stream has now been added into our queue!" }
				else
					redirect_to root_path, flash: { error: "Failed to queue your stream for whatever reason..." }
				end
			end
		end
	end

	def destroy

	end
end
