require_relative "./environment"
class Episode
    attr_accessor :number, :title, :episode_link

    @@all = []

    def initialize(episode_hash)
        episode_hash.each do |key, value|
             self.send("#{key}=", value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def self.create_episodes_from_scrape(season_page_url)
        episodes = Scraper.scrape_episodes_from_season(season_page_url)
        Episode.create_from_array(episodes)
    end

    def self.create_from_array(episode_array)
        episode_array.each do |episode|
            Episode.new(episode)
        end
    end

    def add_attributes(attributes_hash)
        attributes_hash.each do |k, v|
            self.send("#{k}=", v)
        end
    end

    def self.find_by_episode_number(number)
        self.all.find{|episode| episode.number == number }
    end

end