include SessionsHelper

class PlayingsController < ApplicationController
  
  def create
  	# 查询该玩家在指定服务器是否有账号
  	# 如果有，向该服务器发送登陆请求，如果登陆成功则返回OK
  	# 如果没有，创建一条记录再发送登陆请求，返回OK

  	account = Account.find_by_id(params[:account_id])
  	unless account
  		render :json => {:error => "Account not exist"}, :status => 999 and return
  	end

  	game = Game.find_by_name("Dinosaur")
  	unless game
  		render :json => {:error => "Game not exist"}, :status => 999 and return
  	end

  	unless account.playing?(game)
  		playing = account.playings.new :game_id => game.id, :server_id => params[:server_id]
      render playing.errors and return unless playing.save
  	end

  	result = register_game_server(params[:server_id], account)
  	render :json => result


    # playing = @account.playings.build :game_id => params[:game_id], :server_id => params[:server_id]
    # if playing.save
    #   render :json => playing
    # else
    #   render :json => playing.errors, :status => 999
    # end
  end










end
