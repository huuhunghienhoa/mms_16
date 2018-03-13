class CreateActivityLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_logs do |t|
      t.integer :owner_id
      t.string :activity_type
      t.integer :recipient_id
      t.integer :affected_thing_id
      t.string :affected_thing_type

      t.timestamps
    end
  end
end
