class AddVidTypeToVideos < ActiveRecord::Migration[5.1]
  def change
  	add_column :videos, :video_type, :string
  end
end
