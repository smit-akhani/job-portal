class CreateUserDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :user_details do |t|
      t.string :name
      t.string :contact_number
      t.boolean :gender, default: false
      t.references :users
      t.timestamps
    end
  end
end
