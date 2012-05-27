# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Accounts::Application.initialize!


const_dir = "#{Rails.root}/const"
Dir[const_dir + '/*.rb', const_dir + '/**/*.rb'].each{|file| require file}

class String
	# 随机生成一段字符串
	# params:
	# 	n: 字符串的长度
	# 	options: 指定格式(:upcase, :downcase)
	def self.sample(n = 1, options = nil)
		str = ""
		all_words = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
		n.times{str << all_words.sample}

		case options
		when :upcase
			return str.upcase
		when :downcase
			return str.downcase
		else
			return str
		end
	end
end