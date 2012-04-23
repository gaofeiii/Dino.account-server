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

      if server_id && result = register_game_server(server_id, account)
        render :json => {:player_id => result[:player_id], :session_key => account.session_key} and return
      else
        render :json => {:session_key => account.session_key, :servers => Server.list(:name => "Dinosaour")}
      end
    else
      render :json => {:errors => ["email/password doesn't match"]}, :status => 999
    end
  end

  # 试玩请求controller
  # 默认一个设备只能有一个试玩账号
  
  def trying
    # TODO: 需要一个标识设备的唯一ID来完成以下功能
    # 判断该设备是否已经存在试玩账号，如果有，返回该账号
    # 如果没有，创建一个新的试玩账号
    # 
    # account = Account.find_by_device_id_and_account_type(device_id, TRIAL_ACCOUNT_TYPE)
    #
    # For now, set account = nil
    account = nil
    unless account
      account = Account.new :account_type => TRIAL_ACCOUNT_TYPE
      until account.save
        username = "Guest#{String.sample(2).upcase}#{rand(10000000)}"
        account.username = username
        account.password = username + "pass"
        account.password_confirmation = username + "pass"
      end
    end

    create_session(account, request.env['HTTP_UUID'])
    render :json => {:username => account.username, :password => account.password,
      :session_key => account.session_key, :servers => Server.list(:name => "Dinosaour")}
  end
  
  def destroy
    
  end


end
