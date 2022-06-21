class AddGreateInEducation < ActiveRecord::Migration[7.0]
  def change
    add_column :educations, :grade, :string
  end
end
