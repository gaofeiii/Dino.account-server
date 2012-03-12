class PlayingsController < ApplicationController
  
  def create
    playing = @account.playings.build :game_id => params[:game_id], :server_id => params[:server_id]
    if playing.save
      render :json => playing
    else
      render :json => playing.errors, :status => 999
    end
  end
end
