require_relative '../lib/museum.rb'

RSpec.describe do 
  describe 'intra-musuem tests' do
    before :each do 
      @dmns = Museum.new("Denver Museum of Nature and Science")
    end

    it 'exists' do 
      expect(@dmns).to be_a(Museum)
    end

    it 'has a name' do
      expect(@dmns.name).to eq("Denver Museum of Nature and Science")
    end

    it 'starts w empty exhibits' do
      expect(@dmns.exhibits).to eq([])
    end
  end

  describe 'other class interactions' do
    before :each do 
      @dmns = Museum.new("Denver Museum of Nature and Science")

      @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
      @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
      @imax = Exhibit.new({name: "IMAX",cost: 15})

      @patron_1 = Patron.new("Bob", 20)
      @patron_1.add_interest("Dead Sea Scrolls")
      @patron_1.add_interest("Dead Sea Scrolls")

      @patron_2 = Patron.new("Sally", 20)
      @patron_2.add_interest("IMAX")
    end

    it 'can add exhibits' do 
      @dmns.add_exhibit(@gems_and_minerals)
      @dmns.add_exhibit(@dead_sea_scrolls)
      @dmns.add_exhibit(@imax)
      expect(@dmns.exhibits).to eq([@gems_and_minerals, @dead_sea_scrolls, @imax])
    end

    it 'can reccomend exhibits' do 
      expect(@dmns.recommend_exhibits(patron_1)).to eq([@gems_and_minerals, @dead_sea_scrolls])
      expect(@dmns.recommend_exhibits(patron_2)).to eq([@imax])
    end
  end
end
