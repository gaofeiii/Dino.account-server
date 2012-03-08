require 'spec_helper'

describe ServersController do
  
  describe "Get 'index'" do
    
    before(:each) do
      @server1 = Factory(:server)
      @server2 = Factory(:server, :name => Factory.next(:server_name), :address => Factory.next(:address))
      @server3 = Factory(:server, :name => Factory.next(:server_name), :address => Factory.next(:address))
    end
    
    it "should return success" do
      get :index
      response.should be_success
    end
    
    it "should seperate the servers by game id" do
      @server1.update_attributes :game_id => 2
      get :index, :id => 1
      response.should be_success
      response.body.should_not include(@server1.name)
    end
  end
end
