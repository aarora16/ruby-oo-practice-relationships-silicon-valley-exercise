require 'pry'
require './app/models/funding_round.rb'

class VentureCapitalist
    attr_accessor :name, :saved

    @@all = []

    def initialize(name, saved)
        @name = name
        @saved = saved
        @@all << self
    end

    def total_worth
        @total_worth = saved.to_i
    end

    def self.all
        @@all
    end

    def self.tres_commas_club
      self.all.select do |capital|
        capital if capital.total_worth >= 1000000000
      end
      
    end
    
    def offer_contract(startup, type, investment)
        FundingRound.new(startup, self, type, investment)
    end

    def funding_rounds
        FundingRound.all.select do |funding_round|
            funding_round.venture_capitalist == self
        end
    end

    def portfolio
        funding_rounds.map do |vc|
            vc.startup
        end
    end

    def biggest_investment
        biggest = funding_rounds.max do |fr_a, fr_b|
            fr_a.investment <=> fr_b.investment
        end
        biggest.startup 
    end

    def invested(domain)
      rounds = FundingRound.all.select {|round| round.startup.domain == domain}
      total = 0
      rounds.each do |round|
        total += round.investment
      end
      total
    end

end
