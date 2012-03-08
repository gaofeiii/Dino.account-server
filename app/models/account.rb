class Account < ActiveRecord::Base

  has_many :playings, :foreign_key => :account_id, :dependent => :destroy
  
  email_reg = email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  
  validates :email, :presence => true,
                    :format => email_regex,
                    :uniqueness => { :case_sensitive => false }

  def logined?
    
  end


                    
end
