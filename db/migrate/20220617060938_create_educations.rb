class CreateEducations < ActiveRecord::Migration[7.0]
  def change
    create_table :educations do |t|
      t.string :school_name
      t.string :degree
      t.string :field_of_study
      t.string :start_date
      t.string :end_date
      t.boolean :current
      t.references :user, foreign_key: true
      t.text :description
      
      t.timestamps
    end
  end
end
