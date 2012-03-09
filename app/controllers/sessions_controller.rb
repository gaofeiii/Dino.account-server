class SessionsController < ApplicationController
  
  def create
    account = Account.find_by_email(params[:session][:email]).try(:authenticate, params[:session][:password])
    if account
      render :json => account
    else
      render :json => "Login failed!", :status => 999
    end
  end
  
  def destroy
    
  end
end
