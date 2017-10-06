class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
   		t.integer :vid_id 
   		t.integer :vid_duration 
   		t.string :vid_title
   		t.string :vid_copy
      t.timestamps
    end
  end
end
