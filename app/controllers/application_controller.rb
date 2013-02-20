class ApplicationController < ActionController::Base
  protect_from_forgery
 	 
  # before_filter :verify_signature

  def verify_signature
  	# return unless Rails.env.production?
  	
		if request.env['HTTP_SIG'].nil?
			render :json => {:error => "BAD_SIGNATURE"}, :status => 998 and return 
		end
		
		cdate = request.env['HTTP_DATE'].to_i.to_s
		sig  = request.env['HTTP_SIG'].to_s.downcase

		# p '=== request.fullpath ===', request.fullpath
		# p '=== request.raw_post ===', request.raw_post
  # 	p '=== date ===', cdate
  # 	p '=== SIG ===', request.env['HTTP_SIG']

		my_sig = case request.method
		when "GET"
			key_str = "#{request.fullpath}--#{cdate}--#{PRIVATE_KEY}"
			Digest::MD5.hexdigest(key_str)
		when "POST"
			key_str = "#{request.raw_post}--#{cdate}--#{PRIVATE_KEY}"
			Digest::MD5.hexdigest(key_str)
		else
			""
		end
		# p 'my_sig', my_sig

		if sig != my_sig
			render :json => {:error => "Invalid request."}, :status => 998
		end
  end
end
