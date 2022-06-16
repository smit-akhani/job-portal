class CreateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :skills do |t|
      t.string :skill_name
      t.text :skill_description
      t.string :skill_color
      t.timestamps
    end
  end
end
