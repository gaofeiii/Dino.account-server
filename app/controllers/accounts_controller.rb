class AccountsController < ApplicationController
  
  def create
    account = Account.new params.slice(:email, :password, :password_confirmation)
    if account.save
      render :json => account
    else
      render :json => account.errors.messages, :status => 999
    end
  end
end
