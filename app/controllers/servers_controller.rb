class ServersController < ApplicationController
	skip_filter :verify_signature, :only => [:index]
  
  def index
  	p "--- client locale: #{request.env['HTTP_CLIENT_LOCALE']}---"

  	client_locale = request.env['HTTP_CLIENT_LOCALE'].to_s

  	servers = []

  	if params[:game_name].blank?
			render :json => Server.all and return
  	end

    # if client_locale.in?(['cn', 'zh-Hans'])
    #   servers = Server.where(:locale => 'cn')
    # else
    #   # game = Game.find_by_name(params[:game_name])
    #   servers = Server.where(:locale => 'en')
    # end

    # if Rails.env.development?
    #   servers = Server.all
    # end

  	servers = Server.all
    
    render :json => servers
  end
  
end
