class Game < ActiveRecord::Base
  has_many :servers, :foreign_key => :game_id
  has_many :playings, :foreign_key => :game_id
end
