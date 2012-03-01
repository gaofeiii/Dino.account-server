class Account < ActiveRecord::Base
  
  email_reg = email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  
  validates :email, :presence => true,
                    :format => email_regex
end
