class ApplicationController < ActionController::Base
  protect_from_forgery
 	 
  before_filter :find_account
  
  def find_account
    @account = Account.find_by_id(request.env["account_id"])
  end
end
