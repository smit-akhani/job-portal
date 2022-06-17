class CreateExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :experiences do |t|
      t.string :title
      t.string :employment_type
      t.string :company_name 
      t.string :location
      t.string :start_date
      t.string :end_date
      t.boolean :current
      t.text :description
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
