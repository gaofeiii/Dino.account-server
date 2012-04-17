class AddPortToServers < ActiveRecord::Migration
  def change
  	add_column :servers, :ip, :string
  	add_column :servers, :port, :integer
  	remove_column :servers, :address
  end
end
