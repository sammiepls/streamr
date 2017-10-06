class AddColumnEmbedToVideos < ActiveRecord::Migration[5.1]
  def change
  	add_column :videos, :embeddable, :string 
  end
end
