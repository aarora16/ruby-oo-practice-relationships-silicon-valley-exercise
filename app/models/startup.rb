require 'pry'
require './app/models/funding_round.rb'

class Startup
  attr_accessor :name, :domain
  attr_reader :founder

  @@all = []

  def initialize(name, founder, domain)
    @name = name
    @founder = founder
    @domain = domain

    save
  end

  def save
    self.class.all << self
  end

  def pivot(domain, name)
    self.domain = domain
    self.name = name
  end

  def sign_contract(capitalist, type, amount)
    FundingRound.new(self, capitalist, type, amount)
  end

  def self.which_round(name)
    FundingRound.all.select do |round|
      round.startup == name
    end
  end

  def num_funding_rounds
    self.class.which_round(self).count
  end

  def total_funds
    rounds = self.class.which_round(self)
    numbers = rounds.map {|round| round.investment}
    total = 0
    numbers.each {|number| total += number}
    total
  end

  def investors
    rounds = self.class.which_round(self)
    investors = rounds.map {|round| round.venture_capitalist}
    investors.uniq
  end

  def big_investors
    investors = self.investors
    big = VentureCapitalist.tres_commas_club
    investors.map do |investor|
      if big.include? investor
        return investor
      end
    end
  end

  def self.find_by_founder(founder)
    self.all.select { |startup| startup.founder == founder }
  end

  def self.domains
    domains = self.all.map { |startup| startup.domain }
    domains.uniq!
  end

  def self.all
    @@all
  end
end