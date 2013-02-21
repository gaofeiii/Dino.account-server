include SessionsHelper

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

  def self.authenticate_username_and_password(name, pass)
    urname = hexed_username(name, pass)
    account = self.find_by_username(urname)
    if account.try(:authenticate, pass)
      return account
    else
      return false
    end
  end

  def self.find_by_ori_name(name)
    urname = hexed_username(name)
    self.find_by_username(urname)
  end

  def self.find_by_username_or_email(name_or_email)
    Account.find_by_username(name_or_email) || Account.find_by_email(name_or_email)
  end

  def playing?(game)
    self.playings.map(&:game_id).include?(game.id)
  end

  def try_playing(server_ip)
    my_playings = playings
    server = Server.find_by_ip(server_ip)
    if my_playings.where(:server_id => server.id).blank?
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
