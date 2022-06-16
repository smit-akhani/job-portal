class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.text :street
      t.string :area
      t.string :city
      t.string :state
      t.string :country
      t.string :pincode

      t.timestamps
    end
  end
end
