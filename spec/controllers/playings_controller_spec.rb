require 'spec_helper'

describe PlayingsController do
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = Factory(:account)
      @game = Factory(:game)
      @server = Factory(:server, :game_id => @game.id)
    end
    
    it "should create playing relationship" do
      lambda do
        @request.env["account_id"] = @user.id
        post :create, :game_id => @game.id, :server_id => @server.id
        response.should be_success
      end.should change(Playing, :count).by(1)
      @user.should be_playing(@game)
    end
  end
end
