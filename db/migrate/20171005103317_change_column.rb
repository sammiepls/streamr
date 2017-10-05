class ChangeColumn < ActiveRecord::Migration[5.1]
  def change
  	change_column :videos, :vid_id, :string 
  end
end
