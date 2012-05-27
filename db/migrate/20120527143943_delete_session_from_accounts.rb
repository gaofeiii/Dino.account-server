class DeleteSessionFromAccounts < ActiveRecord::Migration
  def change
  	remove_column :accounts, :session_key
  	remove_column :accounts, :session_expired_at
  end
end
