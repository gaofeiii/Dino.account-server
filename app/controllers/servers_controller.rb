class ServersController < ApplicationController
  
  def index
    game = Game.find_by_name(params[:game_name])
    render :json => Server.where(:game_id => game.try(:id))
  end
  
end
