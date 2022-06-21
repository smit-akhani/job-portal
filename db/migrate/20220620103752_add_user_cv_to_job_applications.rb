class AddUserCvToJobApplications < ActiveRecord::Migration[7.0]
  def change
    add_reference :job_applications, :user_cv, null: false, foreign_key: false
  end
end
