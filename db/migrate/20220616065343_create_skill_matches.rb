class CreateSkillMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :skill_matches do |t|
      t.integer :skill_level
      t.references :skill, index: true, foreign_key: true
      t.references :matchable, polymorphic: true
      t.timestamps
    end
  end
end
