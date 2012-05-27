class ServersController < ApplicationController
	before_filter :verify_signature, :only => [:index]
  
  def index
  	render :json => Server.all and return if params[:game_name].nil?
    game = Game.find_by_name(params[:game_name])
    render :json => Server.where(:game_id => game.try(:id))
  end
  
end
