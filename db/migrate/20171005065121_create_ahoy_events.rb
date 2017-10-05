class CreateAhoyEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :ahoy_events do |t|
      t.integer :visit_id
      t.string :name
      t.jsonb :properties
      t.timestamp :time
    end

    add_index :ahoy_events, [:visit_id, :name]
    add_index :ahoy_events, [:name, :time]
  end
end
