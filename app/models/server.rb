class Server < ActiveRecord::Base
  belongs_to :game
  
  class << self

  	def list(options = nil)
  		if options
        Server.all
      else
        Server.where(:name => options[:name])   
      end
  	end
  	
  end


  def as_json(option = nil)
    self.attributes.slice("id", "name", "address", "locale")
  end

end
