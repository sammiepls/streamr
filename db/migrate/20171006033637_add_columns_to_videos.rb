class AddColumnsToVideos < ActiveRecord::Migration[5.1]
  def change
  	add_column :videos, :channel_title, :string 
  	add_column :videos, :channel_id, :string
  end
end
