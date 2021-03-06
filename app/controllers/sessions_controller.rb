include SessionsHelper

class SessionsController < ApplicationController
  before_filter :verify_signature#, :only => [:create, :trying, :update, :change_password]
  
  # 登陆
  def create
    # account = Account.find_by_username(params[:username]) || Account.find_by_email(params[:email])
    # if account.try(:authenticate, params[:password])
    #   account.try_playing(params[:server_id])
    #   render :json => {:account_id => account.id, :success => true}
    # else
    #   render :json => {:success => false}, :status => 999
    # end
    p "==username: #{params[:username]} || ==password: #{params[:password]}"
    account = Account.authenticate_username_and_password(params[:username], params[:password])

    if account
      render :json => {:account_id => account.id, :success => true}
    else
      render :json => {:success => false, :error => "Invalid username & password"}, :status => 999
    end
  end

  # 注册
  def register
    account = Account.new params.slice(:username, :email, :password, :password_confirmation)
    account.username = hexed_username(account.username)
    if account.save
      account.try_playing(params[:server_id])
      render :json => {
        :success => true, :account_id => account.id
      }
      # render :json => {:session_key => account.session_key, :servers => Server.list(:name => "Dinosaur")}
    else
      render :json => {:success => false}.merge(:errors => account.errors.messages), :status => 999
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
      account = Account.new :account_type => ACCOUNT_TYPES[:trial]
      until account.save
        username = "Guest_#{Digest::SHA1.hexdigest(Time.now.to_s + String.sample(2))[8..14]}"
        passwd = String.sample(6)
        account.username = hexed_username(username, passwd)
        account.password = passwd
        account.password_confirmation = passwd
      end
      account.try_playing(params[:server_ip])
    end

    render :json => { 
                      :success    => true,
                      :account_id => account.id,
                      :username   => account.username, 
                      :password   => account.password
                    }
  end

  def update
    account = Account.find_by_id(params[:account_id])

    if account.nil?
      render :json => {:success => false} and return
    end

    account.username = hexed_username(params[:username], params[:password]) if params[:username]
    account.email = params[:email] if params[:email]
    account.password = params[:password]
    account.password_confirmation = params[:password_confirmation]

    data = {}

    if account.save
      data = {:success => true, :account_id => account.id}
    else
      data = {:success => false, :errors => account.errors.messages}
    end
    render :json => data
  end

  def change_password
    ori_name = params[:username]
    hex_name = hexed_username(ori_name, params[:old_pass])

    account = Account.find_by_username(hex_name)
    if account.nil?
      render :json => {
        :success => false, :error => "Invalid username"
      }
      return
    end

    account.password = params[:new_pass]
    # account.password_confirmation = params[:new_pass]
    account.username = hexed_username(ori_name, account.password)

    if account.save
      render :json => {
        :success => true, :message => params[:password]
      }
    else
      render :json => {
        :success => false, :error => "Invalid password"
      }
    end
  end



end
