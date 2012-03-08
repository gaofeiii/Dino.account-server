ActiveAdmin.register Playing do
  index do
    column("Account", :account, :sortable => :account_id)
    column("Game", :game, :sortable => :game_id)
    column("Server", :server, :sortable => :server_id)
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :account, :member_label => :email
      f.input :game
      f.input :server
    end
    f.buttons
  end
end
