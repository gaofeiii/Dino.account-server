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

  def address
    "#{ip}:#{port}"
  end

  def as_json(option = nil)
    hash = self.attributes.slice("name", "ip", "port")
    # hash.merge(:game => game.name)
  end

end
