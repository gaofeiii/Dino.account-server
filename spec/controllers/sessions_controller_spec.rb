require 'spec_helper'

describe SessionsController do
  
  before(:each) do
    @account = FactoryGirl.create(:account)
  end
  
  describe "POST create" do

    it "should login successfully with username" do
      post :create, :username => @account.username, :password => @account.password
      response.should be_success
      response.body.should include("servers")
    end

    it "should login successfully with email" do
      post :create, { :email => @account.email, :password => @account.password }
      response.should be_success
      response.body.should include("servers")
    end

    it "should register game server successfully when login" do
      controller.stub(:register_game_server).and_return(true)
      server = FactoryGirl.create(:server)
      post :create, :username => @account.username, :password => @account.password, :server_id => server.id
      response.should be_success
      response.body.should include("session_key")
    end
    
    it "should reject when given wrong password" do
      post :create, { :email => @account.email, :password => "WrongPassword" }
      response.should_not be_success
    end
  end
end
