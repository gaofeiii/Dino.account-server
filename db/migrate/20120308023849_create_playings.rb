class CreatePlayings < ActiveRecord::Migration
  def change
    create_table :playings do |t|
      t.integer :account_id
      t.integer :game_id
      t.integer :server_id
      t.timestamps
    end
    add_index :playings, :account_id
    add_index :playings, :game_id
  end
end
