class Game < ActiveRecord::Base
  has_many :servers, :foreign_key => :game_id
end
