require 'spec_helper'

describe ServersController do
  
  describe "Get 'index'" do
    
    before(:each) do
      @game = Factory(:game)
      @server1 = Factory(:server)
      @server2 = Factory(:server, :name => Factory.next(:server_name), :address => Factory.next(:address))
      @server3 = Factory(:server, :name => Factory.next(:server_name), :address => Factory.next(:address))
      (1..3).each{|i| eval("@server#{i}.update_attributes :game_id => #{@game.id}")}
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
