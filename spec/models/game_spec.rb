require 'spec_helper'

describe Game do
  
  describe "validations" do
    
    it "should have a name attribute" do
      Game.new().should respond_to(:name)
    end
  end
end
