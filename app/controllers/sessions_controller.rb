include SessionsHelper

class SessionsController < ApplicationController
  
  def create
    account = Account.find_by_username(params[:username]) || Account.find_by_email(params[:email])
    if account.try(:authenticate, params[:password])
      # NOTE: 登陆流程
      # 验证用户名和密码通过，生成session_key
      # 
      # 如果params中含有server_id，向指定的server发送session_key
      # 如果没有，则需要向客户端返回server_list
      # 将session_key返回给客户端
      create_session(account, request.env['HTTP_UUID'])
      server_id = params[:server_id]

      if server_id
        if register_game_server(server_id, account)
          render :json => {:session_key => account.session_key} and return
        end
      else
        render :json => {:session_key => account.session_key, :servers => Server.list}
      end


    else
      render :json => {:errors => ["email/password doesn't match"]}, :status => 999
    end
  end
  
  def destroy
    
  end
end
