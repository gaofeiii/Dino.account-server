class ApplicationController < ActionController::Base
  protect_from_forgery
 	 
  # before_filter :verify_signature

  def verify_signature
  	# return unless Rails.env.production?

  	
		if request.env['HTTP_SIG'].nil?
			render :json => {:error => "Invalid request."}, :status => 998 and return 
		end
		
		date = request.env['HTTP_DATE'].to_time.to_i.to_s
		sig  = request.env['HTTP_SIG'].to_s.downcase

		p '=== request.url ===', request.url
  	p '=== date ===', date
  	p '=== SIG ===', request.env['HTTP_SIG']

		my_sig = case request.method
		when "GET"
			Digest::MD5.hexdigest(request.url + date + PRIVATE_KEY)
		when "POST"
			Digest::MD5.hexdigest(request.raw_post + date + PRIVATE_KEY)
		else
			""
		end
		p 'my_sig', my_sig

		if sig != my_sig
			render :json => {:error => "Invalid request."}, :status => 998
		end
  end
end
