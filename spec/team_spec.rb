require_relative "./spec_helper.rb"

describe Team do
    it 'has a name' do
        team = Team.new
        team.name = "Nick & Starr"
        expect(team.name).to eq("Nick & Starr")
    end
end