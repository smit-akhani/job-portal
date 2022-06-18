class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true
      t.text :job_description 
      t.string :job_title
      t.integer :year_of_exp
      t.string :location
      t.date :last_date_to_apply
      t.boolean :easy_apply
      t.string :job_application_link 
      t.timestamps
    end
  end
end
