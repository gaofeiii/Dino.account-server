class Playing < ActiveRecord::Base
  belongs_to :account
  belongs_to :game
  belongs_to :server
end
