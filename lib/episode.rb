require_relative "./environment"
class Episode
    extend Behavior::ClassMethods
    include Behavior::InstanceMethods

    attr_accessor :number, :title, :episode_link, :air_date, :route_info, :season, :last_team, :elimination, :teams

    @@all = []

    def self.all
        @@all
    end

    def self.create_episodes_from_scrape(season_page_url)
        episodes = Scraper.scrape_episodes_from_season(season_page_url)
        Episode.create_from_array(episodes)
    end

    def self.find_by_episode_number(number)
        self.all.find{|episode| episode.number == number }
    end

end