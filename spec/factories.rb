FactoryGirl.define do
  
  factory :account do
    email                   "gaofei@email.com"
    password                "haha123"
    password_confirmation   "haha123"
  end

  factory :game do
    name    "Dinosaur"
  end

  factory :server do
    name                     "OMG"
    address                  "http://localhost:3000"
    locale                   "cn"
    game_id                  1
  end

  sequence :server_name do |n|
    "Test Server #{n}"
  end

  sequence :address do |n|
    "http://localhost:300#{n}"
  end

end




# Factory.define :account do |account|
#   account.email                   "gaofei@email.com"
#   account.password                "haha123"
#   account.password_confirmation   "haha123"
# end

# Factory.define :game do |game|
#   game.name                       "Dinosaur"
# end

# Factory.define :server do |server|
#   server.name                     "OMG"
#   server.address                  "http://localhost:3000"
#   server.locale                   "cn"
#   server.game_id                  1
# end

# Factory.sequence :server_name do |n|
#   "Test Server #{n}"
# end

# Factory.sequence :address do |n|
#   "http://localhost:300#{n}"
# end