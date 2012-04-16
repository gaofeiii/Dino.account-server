class Server < ActiveRecord::Base
  belongs_to :game
  
  class << self

  	def list
  		Server.all
  	end
  	
  end


  def as_json(option = nil)
    self.attributes.slice("id", "name", "address", "locale")
  end

end
