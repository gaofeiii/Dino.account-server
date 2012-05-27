module SessionsHelper

	# def create_session(account, uuid)
	# 	s_key = Digest::SHA2.hexdigest(account.username + account.email.to_s + uuid.to_s + Time.now.to_s + LOGIN_PRIVATE_KEY)
	# 	account.update_attributes :session_key => s_key, :session_expired_at => Time.now + 1.day
	# end

	# def register_game_server(server_id, account)
	# 	server = Server.find_by_id(server_id)
	# 	if server
	# 		# post account to server
	# 		uri = URI(server.address + '/sessions')
	# 		res = Net::HTTP.post_form(uri, 'account_id' => account.id, 'session_key' => account.session_key)	
	# 		return JSON.parse(res.body).symbolize_keys if res.code == "200"
	# 	else
	# 		false		
	# 	end
	# end
end
