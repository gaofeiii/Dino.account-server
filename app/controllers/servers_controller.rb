class ServersController < ApplicationController
	before_filter :verify_signature, :only => [:index]
  
  def index
  	if params[:game_name].blank?
			render :json => Server.all and return
  	end
  	
    game = Game.find_by_name(params[:game_name])
    render :json => Server.where(:game_id => game.try(:id))
  end
  
end
