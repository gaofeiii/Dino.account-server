include SessionsHelper

class AccountsController < ApplicationController
  
  def create
    account = Account.new params.slice(:username, :email, :password, :password_confirmation)
    if account.save
    	create_session(account, request.env['HTTP_UUID'])
    	render :json => {:session_key => account.session_key, :servers => Server.list(:name => "Dinosaur")}
    else
      render :json => account.errors.messages, :status => 999
    end
  end
end
