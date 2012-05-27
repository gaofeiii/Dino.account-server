class ApplicationController < ActionController::Base
  protect_from_forgery
 	 
  before_filter :verify_signature

  def verify_signature
  	return unless Rails.env.production?
  	
		if request.env['HTTP_SIG'].nil?
			render :json => {:error => "Invalid request."}, :status => 998 and return 
		end
		
		date = request.env['HTTP_DATE']
		sig  = request.env['HTTP_SIG'].to_s.downcase

		my_sig = case request.method
		when "GET"
			Digest::MD5.hexdigest(request.url + request.env['HTTP_DATE'] + PRIVATE_KEY)
		when "POST"
			Digest::MD5.hexdigest(request.raw_post + request.env['HTTP_DATE'] + PRIVATE_KEY)
		else
			""
		end

		if sig != my_sig
			render :json => {:error => "Invalid request."}, :status => 998
		end
  end
end
