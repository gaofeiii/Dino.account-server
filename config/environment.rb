# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Accounts::Application.initialize!

const_dir = "#{Rails.root}/config/const"
Dir[const_dir + '/*.rb', const_dir + '/**/*.rb'].each{|file| require file}

class String
	def self.sample(n = 10)
		str = ""
		all_words = ('a'..'z').to_a + ('A'..'Z').to_a
		n.times{str += all_words.sample}
		str
	end
end