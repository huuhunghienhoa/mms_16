class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.datetime :birthday
      t.string :avatar
      t.integer :team_id
      t.references :team, index: true, foreign_key: true
      t.references :position, foreign_key: true
      t.string :password_digest
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
