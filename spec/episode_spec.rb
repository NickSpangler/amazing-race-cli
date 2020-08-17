require_relative "./spec_helper.rb"

describe Episode do
    it 'has a name' do
        episode = Episode.new
        episode.name = "Episode 1"
        expect(episode.name).to eq("Episode 1")
    end
end