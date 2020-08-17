require_relative "./spec_helper.rb"

describe Season do
    it 'has a name' do
        season = Season.new
        season.name = "Season 13"

        expect(season.name).to eq("Season 13")
    end

    context 'with teams' do
        it 'has an empty array of teams when initialized'
    end
end