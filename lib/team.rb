require_relative "./environment"
class Team
    attr_accessor :name, :profile_link

    @@all = []

    def initialize(team_hash)
        team_hash.each do |key, value|
             self.send("#{key}=", value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def self.create_from_array(teams_array)
        teams_array.each do |team|
            Team.new(team)
        end
    end

    def self.create_from_scrape(season_page_url)
        teams = Scraper.scrape_teams_from_season(season_page_url)
        Team.create_from_array(teams)
    end
    
end