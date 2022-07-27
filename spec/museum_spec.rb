require_relative '../lib/museum.rb'

RSpec.describe do 
  describe 'intra-musuem tests' do
    before :each do 
      @dmns = Museum.new("Denver Museum of Nature and Science")
    end

    it '#exists' do 
      expect(@dmns).to be_a(Museum)
    end

    it '#has a name' do
      expect(@dmns.name).to eq("Denver Museum of Nature and Science")
    end

    it '#starts w empty exhibits' do
      expect(@dmns.exhibits).to eq([])
    end
  end

  describe 'other class interactions' do
    before :each do 
      @dmns = Museum.new("Denver Museum of Nature and Science")

      @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
      @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
      @imax = Exhibit.new({name: "IMAX",cost: 15})

      @dmns.add_exhibit(@gems_and_minerals)
      @dmns.add_exhibit(@dead_sea_scrolls)
      @dmns.add_exhibit(@imax)

      @patron_1 = Patron.new("Bob", 20)
      @patron_1.add_interest("Gems and Minerals")
      @patron_1.add_interest("Dead Sea Scrolls")

      @patron_2 = Patron.new("Sally", 20)
      @patron_2.add_interest("IMAX")
    end

    it '#can add exhibits' do 
      expect(@dmns.exhibits).to eq([@gems_and_minerals, @dead_sea_scrolls, @imax])
    end

    it '#can reccomend exhibits' do 
      expect(@dmns.reccomend_exhibits(@patron_1)).to eq([@gems_and_minerals, @dead_sea_scrolls])
      expect(@dmns.reccomend_exhibits(@patron_2)).to eq([@imax])
    end
  end

  describe 'iteration 3 feature' do
    before :each do
      @dmns = Museum.new("Denver Museum of Nature and Science")

      @gems_and_minerals = Exhibit.new({ name: "Gems and Minerals", cost: 0 })
      @dead_sea_scrolls = Exhibit.new({ name: "Dead Sea Scrolls", cost: 10 })
      @imax = Exhibit.new({ name: "IMAX",cost: 15 })

      @dmns.add_exhibit(@gems_and_minerals)
      @dmns.add_exhibit(@dead_sea_scrolls)
      @dmns.add_exhibit(@imax)

      @patron_1 = Patron.new("Bob", 0)
      @patron_1.add_interest("Gems and Minerals")
      @patron_1.add_interest("Dead Sea Scrolls")

      @patron_2 = Patron.new("Sally", 20)
      @patron_2.add_interest("Dead Sea Scrolls")

      @patron_3 = Patron.new("Johnny", 5)
      @patron_3.add_interest("Dead Sea Scrolls")
    end

    it 'can admit patrons' do
      expect(@dmns.patrons).to eq([@patron_1, @patron_2, @patron_3])
    end

    it 'can find patrons by exhibit interest' do
      expect(@dmns.patrons_by_exhibit_interest).to eq({ @gems_and_minerals => [@patron_1], @dead_sea_scrolls => [@patron_1, @patron_2, @patron_3], @imax => [] })
    end

    it 'can find lotto contestants' do
      expect(@dmns.ticket_lottery_contestants(@dead_sea_scrolls)).to eq([@patron_1, @patron_3])
    end

    it 'can draw lotto winner' do
      expect(["Bob", "Johnny"].include?(@dmns.draw_lottery_winner(@dead_sea_scrolls))).to eq(true)
      expect(@dmns.draw_lottery_winner(@dead_sea_scrolls)).to eq(nil)
    end

    it 'can announce lotto winner' do
      possibilities = ["Bob has won the IMAX exhibit lottery", "Johnny has won the IMAX exhibit lottery"]
      expect(possibilities.include?(@dmns.draw_lottery_winner(@imax))).to eq(true)

      expect(@dmns.announce_lottery_winner(gems_and_minerals)).to eq("No winners for this lottery")
    end
  end
end
