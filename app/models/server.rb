class Server < ActiveRecord::Base
  belongs_to :game
  
  def as_json(option = nil)
    self.attributes.slice("id", "name", "address", "locale")
  end
end
