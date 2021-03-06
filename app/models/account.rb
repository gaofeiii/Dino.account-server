include SessionsHelper

class Account < ActiveRecord::Base

  has_many :playings, :foreign_key => :account_id, :dependent => :destroy

  before_save :hex_username

  email_reg = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # TODO: 完成用户名的正则表达式
  # name_reg = /

  ORIGIN_GUEST_NAME_REG = /Guest_[A-Za-z0-9]{7}/
  HEXED_GUEST_NAME_REG = /Guest_[A-Za-z0-9]{7}_[A-Za-z0-9]{32}$}/

  ORIGIN_NORMAL_NAME_REG = /[A-Za-z0-9\u4E00-\uFA29]{3,12}/
  HEXED_NORMAL_NAME_REG =/[A-Za-z0-9\u4E00-\uFA29]{2,16}_[A-Za-z0-9]{32}$/

  HEXED_REG = /_[A-Za-z0-9]{32}$/

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

  def is_hexed_username?
    !!(self.username =~ HEXED_REG)
  end

  def ori_name
    if is_hexed_username?
      username.gsub(HEXED_REG, '')
    else
      username
    end
  end

  def as_json(args = nil)
    self.attributes.slice("id", "email")
  end

  def init_email
    self.email = nil if email.blank?
  end

  protected
  def hex_username
    if password
      self.username = hexed_username(ori_name, password)
    end
  end


end
