require 'spec_helper'

describe AccountsController do
  
  describe "POST create" do
    
    before(:each) do
      @attr = { :username => 'gaofei', :email => "gaofei@email.com", :password => "haha123", :password_confirmation => "haha123" }
    end
    
    it "should create user success" do
      lambda do
        post :create, @attr
        response.should be_success
      end.should change(Account, :count).by(1)
    end

    it "should create user successfully without email" do
      lambda do
        post :create, @attr.merge(:email => nil)
        response.should be_success
      end.should change(Account, :count).by(1)
    end
    
    it "should not allow to create an account" do
      lambda do
        post :create, @attr.merge(:email => "bademail")
        response.should_not be_success
      end.should_not change(Account, :count)
    end
  end
end
