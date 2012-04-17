require 'spec_helper'

describe PlayingsController do
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = FactoryGirl.create(:account)
      @game = FactoryGirl.create(:game)
      @server = FactoryGirl.create(:server, :game_id => @game.id)
      controller.stub(:register_game_server).and_return(true)
    end
    
    it "should create playing relationship" do
      lambda do
        post :create, :account_id => @user.id, :game_id => @game.id, :server_id => @server.id
        response.should be_success
      end.should change(Playing, :count).by(1)
      @user.should be_playing(@game)
    end
    
    it "should reject create playing relationship when given wrong server id" do
      lambda do
        @request.env["account_id"] = @user.id
        post :create, :game_id => @game.id, :server_id => 111
        response.should_not be_success
      end.should_not change(Playing, :count)
    end
    
    it "should reject create playing relationship when given wrong game id" do
      lambda do
        @request.env["account_id"] = @user.id
        post :create, :game_id => 1231, :server_id => @server.id
        response.should_not be_success
      end.should_not change(Playing, :count)
    end
  end
end
