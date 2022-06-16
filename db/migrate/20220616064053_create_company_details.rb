class CreateCompanyDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :company_details do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.text :about
      t.string :phone

      t.timestamps
    end
  end
end
