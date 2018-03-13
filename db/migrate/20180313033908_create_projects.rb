class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.references :team, index: true, foreign_key: true
      t.integer :leader_id
      t.datetime :date_start
      t.datetime :date_end

      t.timestamps
    end
  end
end
