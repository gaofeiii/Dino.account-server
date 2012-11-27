class Account < ActiveRecord::Base

  has_many :playings, :foreign_key => :account_id, :dependent => :destroy

  email_reg = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # TODO: 完成用户名的正则表达式
  # name_reg = /
  has_secure_password

  before_save :init_email
  
  validates :email, :allow_blank => true,
                    :format => email_reg,
                    :uniqueness => { :case_sensitive => false }

  validates :username,  :presence => true,
                        # :format => name_regex,
                        :uniqueness => { :case_sensitive => false }

  def logined?
    
  end

  def self.find_by_username_or_email(name_or_email)
    Account.find_by_username(name_or_email) || Account.find_by_email(name_or_email)
  end

  def playing?(game)
    self.playings.map(&:game_id).include?(game.id)
  end

  def try_playing(server_id)
    my_playings = playings
    if my_playings.where(:server_id => server_id).blank?
      server = Server.find_by_id(server_id)
      my_playings.create(:server_id => server.id, :game_id => server.game_id)
    end
  end

  def as_json(args = nil)
    self.attributes.slice("id", "email")
  end

  def init_email
    self.email = nil if email.blank?
  end

end
