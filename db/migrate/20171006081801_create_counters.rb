class CreateCounters < ActiveRecord::Migration[5.1]
  def change
    create_table :counters do |t|
      t.integer :current_index, default: 0
      t.timestamps
    end
  end
end
