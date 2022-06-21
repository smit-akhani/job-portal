class CreateJobAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :job_alerts do |t|
      t.references :user, foreign_key: true
      t.string :job_title
      t.string :location, :null =>  true
      t.timestamps
    end
  end
end
