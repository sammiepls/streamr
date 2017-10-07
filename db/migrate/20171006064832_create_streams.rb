class CreateStreams < ActiveRecord::Migration[5.1]
  def change
    create_table :streams do |t|
	  t.string :stream_id
	  t.string :stream_title
	  t.string :channel_id
	  t.string :channel_title
	  t.string :streamer
      t.timestamps
    end
  end
end
