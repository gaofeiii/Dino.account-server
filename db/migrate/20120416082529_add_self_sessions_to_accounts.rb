class AddSelfSessionsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :session_key, :string
    add_column :accounts, :session_expired_at, :Time
    
    add_index :accounts, :session_expired_at
  end
end
