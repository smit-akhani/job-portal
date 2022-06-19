class CreateJobManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :job_managers do |t|
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true
      t.timestamps
    end
    add_index :job_managers, [:user_id, :company_id], unique: true

  end
end
