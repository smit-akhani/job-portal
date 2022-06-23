class AddTrackable < ActiveRecord::Migration[7.0]
  def change
    # NOTE for users 
    add_column :users, :sign_in_count, :integer, default: 0, null: false 
    add_column :users, :current_sign_in_at,:datetime
    add_column :users, :last_sign_in_at,:datetime
    add_column :users, :current_sign_in_ip,:inet
    add_column :users, :last_sign_in_ip,:inet
    
    
    # NOTE for companys 
    add_column :companies, :sign_in_count, :integer, default: 0, null: false 
    add_column :companies, :current_sign_in_at,:datetime
    add_column :companies, :last_sign_in_at,:datetime
    add_column :companies, :current_sign_in_ip,:inet
    add_column :companies, :last_sign_in_ip,:inet
    
  end
end
