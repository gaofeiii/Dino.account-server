class SessionsController < ApplicationController
  
  def create
    account = Account.find_by_email(params[:session][:email]).try(:authenticate, params[:session][:password])
    unless account.nil?
      render :json => "Login success!!!"
    else
      render :json => "Login failed!", :status => 999
    end
  end
  
  def destroy
    
  end
end
