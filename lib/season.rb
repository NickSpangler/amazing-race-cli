describe Season do
    it 'has a name' do
        season13 = Season.new
        season13.name = "Season 13"
        expect(season13.name).to eq("Season 13")
    end
end