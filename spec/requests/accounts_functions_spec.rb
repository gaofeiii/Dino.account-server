require 'spec_helper'

describe "AccountsFunctions" do
  
  describe "Post 'Signup'" do
    
    before(:each) do
      @attr = { :email => "gaofei@email.com", :password => "haha123", :password_confirmation => "haha123" }
    end
    
    it "should create an account success" do
      lambda do
        post '/signup', @attr
        response.should be_success
      end.should change(Account, :count).by(1)
    end
  end
  
  describe "Post 'Signin" do
    
    before(:each) do
      @account = FactoryGirl.create(:account)
    end
    
    it "should singin success" do
      post '/signin', :session => { :email => @account.email, :password => @account.password }
      response.should be_success
    end
  end
  
  describe "server list" do
    
    before(:each) do
      @game = FactoryGirl.create(:game)
      @server = FactoryGirl.create(:server, :game_id => @game.id)
    end
    
    it "should get specified game server list" do
      get '/server_list', :game_name => @game.name
      response.should be_success
      response.body.should include(@server.name)
    end
  end
  
  describe "user choose game server" do
    
    before(:each) do
      @user = FactoryGirl.create(:account)
      @game = FactoryGirl.create(:game)
      @server = FactoryGirl.create(:server, :game_id => @game.id)
    end
    
    it "should have the right route to choose a server" do
      post_via_redirect('/choose_server', {:game_id => @game.id, :server_id => @server.id}, {"account_id" => @user.id})
      response.should be_success
      @user.should be_playing(@game)
    end
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end
