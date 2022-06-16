class CreateUserCvs < ActiveRecord::Migration[7.0]
  def change
    create_table :user_cvs do |t|
      t.string :title
      t.boolean :is_default
      t.references :users
      t.timestamps
    end
  end
end
