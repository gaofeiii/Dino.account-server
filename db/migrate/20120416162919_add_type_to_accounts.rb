class AddTypeToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :account_type, :integer, :default => 1
  end
end
