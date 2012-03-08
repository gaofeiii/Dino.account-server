class Server < ActiveRecord::Base
  belongs_to :game
  
  def as_json(option = nil)
    self.attributes.slice("name", "address", "locale")
  end
end
