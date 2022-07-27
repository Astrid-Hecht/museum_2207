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

end
