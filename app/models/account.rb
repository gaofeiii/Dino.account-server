class Account < ActiveRecord::Base

  has_many :playings, :foreign_key => :account_id, :dependent => :destroy

  email_reg = email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # name_reg = //
  has_secure_password
  
  validates :email, :presence => false,
                    :format => email_regex,
                    :uniqueness => { :case_sensitive => false }

  validates :username,  :presence => true,
                        # :format => name_regex,
                        :uniqueness => { :case_sensitive => false }

  def logined?
    
  end

  def playing?(game)
    self.playings.map(&:game_id).include?(game.id)
  end

  def as_json(args = nil)
    self.attributes.slice("id", "email")
  end

end
