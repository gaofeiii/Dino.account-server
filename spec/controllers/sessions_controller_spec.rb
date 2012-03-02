require 'spec_helper'

describe SessionsController do
  
  before(:each) do
    @account = Factory(:account)
  end
  
  describe "POST create" do
    it "should be login success" do
      post :create, :session => { :email => @account.email, :password => @account.password }
      response.should be_success
    end
  end
end
