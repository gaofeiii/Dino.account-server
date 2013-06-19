class ServerInfo

	@@info = {}

	def self.all
		if @@info.blank?
			load_info!
		end
		@@info
	end

	def self.load_info!
		@@info = YAML.load_file(Rails.root.join('config').join('server_info.yml')).deep_symbolize_keys
	end

	def self.current
		hostname = Socket.gethostname.to_sym
		all[hostname]
	end

	def self.current_env
		current[:env] || 'development'
	end
end