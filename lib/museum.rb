require_relative './exhibit'
require_relative './patron'

class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit if exhibit.is_a? Exhibit
  end

  def reccomend_exhibits(patron)
    @exhibits.find_all { |exhibit| patron.interests.include?(exhibit.name) }
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    patron_groups = []
    @exhibits.each do |exhibit|
      patron_groups << @patrons.find_all { |patron| patron.interests.include?(exhibit.name)}
    end
    Hash[@exhibits.zip(patron_groups)]
  end

  def ticket_lottery_contestants(exhibit)
    @patrons.find_all { |patron| patron.interests.include?(exhibit.name) && patron.spending_money < exhibit.cost}
  end

  def draw_lottery_winner(exhibit)
    contestants = ticket_lottery_contestants(exhibit)
    contestants[Random.new.rand(0..(contestants.count - 1))].name if contestants.count.positive?
  end

  def announce_lottery_winner(exhibit)
    if draw_lottery_winner(exhibit)
      "#{draw_lottery_winner(exhibit)} has won the #{exhibit.name} exhibit lottery"
    else
      "No winners for this lottery"
    end
  end
end
