require_relative "./spec_helper.rb"

describe Season do
    it 'is initialized from a scraped url' do
        season = Season.new("https://amazingrace.fandom.com/wiki/The_Amazing_Race_13")
        

    end
    it 'has a name' do
        season = Season.new
        season.name = "Season 13"

        expect(season.name).to eq("Season 13")
    end

    context 'with teams' do
        it 'has an empty array of teams when initialized' do
        season = Season.new

        expect(season.teams).to match_array([])
        end
    end 

end