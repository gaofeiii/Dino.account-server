class Playing < ActiveRecord::Base
  belongs_to :account
  belongs_to :game
  belongs_to :server
  
  include ActiveModel::Validations
  
  validate do
    unless Server.find_by_id(self.server_id)
      errors.add(:server_id, :empty_server)
    end
    
    unless Game.find_by_id(self.game_id)
      errors.add(:game_id, :no_such_game)
    end
  end
  
  def as_json(options = nil)
    self.attributes.slice "account_id", "game_id", "server_id"
  end
  
end
