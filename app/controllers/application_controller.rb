class ApplicationController < ActionController::Base
  protect_from_forgery
 	 
  before_filter :verify_signature

  def verify_signature
  	if Rails.env.production?
  		# TODO: verify signature
  		# date = request.env['HTTP_DATE']
  		# sig  = request.env['HTTP_SIG']
  	end
  end
end
