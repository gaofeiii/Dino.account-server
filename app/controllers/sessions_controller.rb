class SessionsController < ApplicationController
  
  def create
    account = Account.find_by_email(params[:session][:email]).try(:authenticate, params[:session][:password])
    if account
      render :json => account
      # TODO: signin process
      # 验证用户名和密码通过，生成session_key
      # 
      # 如果params中含有server_id，向指定的server发送session_key
      # 如果没有，则需要向客户端返回server_list
      # 将session_key返回给客户端
      # 

    else
      render :json => "email/password doesn't match", :status => 999
    end
  end
  
  def destroy
    
  end
end
