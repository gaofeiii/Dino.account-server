class ServersController < ApplicationController
  
  def index
    render :json => Server.where(:game_id => params[:id])
  end
end
