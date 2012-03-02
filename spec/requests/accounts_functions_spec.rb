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
      @account = Factory(:account)
    end
    
    it "should singin success" do
      post '/signin', :session => { :email => @account.email, :password => @account.password }
      response.should be_success
    end
  end
  
end
