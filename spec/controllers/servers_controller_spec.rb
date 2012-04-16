require 'spec_helper'

describe ServersController do
  
  describe "Get 'index'" do
    
    before(:each) do
      @game = FactoryGirl.create(:game)
      @server1 = FactoryGirl.create(:server, :game_id => @game.id)
      @server2 = FactoryGirl.create(:server, :game_id => @game.id, :name => FactoryGirl.generate(:server_name), :address => FactoryGirl.generate(:address))
      @server3 = FactoryGirl.create(:server, :game_id => @game.id, :name => FactoryGirl.generate(:server_name), :address => FactoryGirl.generate(:address))
    end
    
    it "should return success" do
      get :index
      response.should be_success
    end
    
    it "should seperate the servers by game id" do
      @server1.update_attributes :game_id => 2
      get :index, :game_name => @game.name
      response.should be_success
      response.body.should_not include(@server1.name)
    end
  end
end
