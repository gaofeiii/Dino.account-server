class ChangeEmailToAccounts < ActiveRecord::Migration
  def change
  	change_table :accounts do |t|
  		t.remove :email
  		t.string :email
  		t.index :email, :unique => true
  	end
  end
end
