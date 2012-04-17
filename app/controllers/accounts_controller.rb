class AccountsController < ApplicationController
  
  def create
    account = Account.new params.slice(:username, :email, :password, :password_confirmation)
    if account.save
    	render :json => {:account => account.as_json, :servers => Server.list(:name => "Dinosaur")}
    else
      render :json => account.errors.messages, :status => 999
    end
  end
end
