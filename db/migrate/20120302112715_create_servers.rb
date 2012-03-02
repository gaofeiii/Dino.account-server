class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :address
      t.string :locale
      t.integer :game_id
      t.timestamps
    end
    add_index :servers, :name, :unique => true
    add_index :servers, :game_id
    add_index :servers, :locale
  end
end
