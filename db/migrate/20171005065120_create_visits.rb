class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.string :visit_token
      t.string :visitor_token
      t.string :ip

      t.timestamp :started_at
    end

    add_index :visits, [:visit_token], unique: true
  end
end
