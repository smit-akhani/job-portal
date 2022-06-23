class AddEmailConfirmation < ActiveRecord::Migration[7.0]
  def change
    # NOTE for users 
    add_column :users, :confirmation_token, :string 
    add_column :users, :confirmed_at, :datetime 
    add_column :users, :confirmation_sent_at, :datetime 
    add_column :users, :unconfirmed_email, :string 

    add_column :users, :failed_attempts, :integer , default: 0, null: false 
    add_column :users, :unlock_token, :string 
    add_column :users, :locked_at, :datetime 
    
    
    # NOTE for companys 
    add_column :companies, :confirmation_token, :string 
    add_column :companies, :confirmed_at, :datetime 
    add_column :companies, :confirmation_sent_at, :datetime 
    add_column :companies, :unconfirmed_email, :string 
    add_column :companies, :failed_attempts, :integer , default: 0, null: false 
    add_column :companies, :unlock_token, :string 
    add_column :companies, :locked_at, :datetime 
    
  end
end
