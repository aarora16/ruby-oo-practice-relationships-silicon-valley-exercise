require_relative '../config/environment.rb'
require_relative '../app/models/funding_round.rb'
require_relative '../app/models/venture_capitalist.rb'

def reload
  load 'config/environment.rb'
end
# Insert code here to run before hitting the binding.pry
# This is a convenient place to define variables and/or set up new object instances,
# so they will be available to test and play around with in your console


first_startup = Startup.new("Microsoft", "John", "Tech")
second_startup = Startup.new("Airbnb", "Jeff", "Renting")
third_startup = Startup.new("Apple", "Steve", "Technology")
fourth_startup = Startup.new("Tesla", "Billy", "Tech")

first_investor = VentureCapitalist.new("Billy", "1000000000")
second_investor = VentureCapitalist.new("Bob", "40000000")
third_investor = VentureCapitalist.new("Ted", "49999999999999")

# first_round = first_startup.sign_contract(first_investor, "Angel", 1000)
second_round = first_investor.offer_contract(first_startup, "Angel", 10000)
third_round = second_startup.sign_contract(second_investor, "Angel", 300)
fourth_round = second_investor.offer_contract(first_startup, "Angel", 5000)



binding.pry
0 #leave this here to ensure binding.pry isn't the last line