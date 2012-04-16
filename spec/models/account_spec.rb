require 'spec_helper'

describe Account do
  
  describe "validations" do
    
    before(:each) do
      @attr = { :email => "gaofei@email.com", :password => "haha123", :password_confirmation => "haha123" }
    end
    
    it "should not be valid when email is blank" do
      Account.new(@attr.merge(:email => "")).should_not be_valid
    end
    
    it "should not be valid when email is invalid" do
      Account.new(@attr.merge(:email => "bademail")).should_not be_valid
    end
    
    it "should not be valid when email is used" do
      Account.create @attr
      Account.new(@attr.merge(:email => "GAOFEI@email.com")).should_not be_valid
    end
    
    it "should not be valid when password is blank" do
      Account.new(@attr.merge(:password => "")).should_not be_valid
    end
    
    it "should not be valid when password doesn't match" do
      Account.new(@attr.merge(:password_confirmation => "bad password")).should_not be_valid
    end
    
    it "should be valid" do
      Account.new(@attr).should be_valid
    end
    
    it "should create an account" do
      lambda do
        Account.create @attr
      end.should change(Account, :count).by(1)
    end
  end


  
  describe "methods validations" do
    
    before(:each) do
      @account = FactoryGirl.create(:account)
    end
    
    it "should have a specified to_json method" do
      @account.to_json.should include("id")
      @account.to_json.should_not include("created_at")
    end    
  end







end
