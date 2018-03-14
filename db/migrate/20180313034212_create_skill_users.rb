class CreateSkillUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :skill_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :skill, index: true, foreign_key: true
      t.integer :level
      t.integer :years_experience

      t.timestamps
    end
  end
end
