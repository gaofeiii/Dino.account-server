ActiveAdmin.register Server do
  index do
    column(:id, :sortable => :id)
    column :name
    column :ip
    column :port
    column :locale
    column("Game", :game, :sortable => :game_id)
    default_actions
  end
end
