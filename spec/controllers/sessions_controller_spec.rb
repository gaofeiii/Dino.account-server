require 'spec_helper'

describe SessionsController do
  
  before(:each) do
    @account = FactoryGirl.create(:account)
  end
  
  describe "POST create" do

    it "should be login successfully with username" do
      post :create, :username => @account.username, :password => @account.password
      response.should be_success
      response.body.should include(@account.id.to_s)
    end

    it "should be login successfully with email" do
      post :create, { :email => @account.email, :password => @account.password }
      response.should be_success
      response.body.should include(@account.id.to_s)
    end
    
    it "should reject when given wrong password" do
      post :create, { :email => @account.email, :password => "WrongPassword" }
      response.should_not be_success
    end
  end
end
