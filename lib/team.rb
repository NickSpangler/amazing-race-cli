require_relative "./environment"
class Team
    attr_accessor :name, :profile_link, :about, :profile, :post_race, :trivia, :place, :hometown, :relationship, :occupation, :season, :finish, :season_number

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

    def self.create_teams_from_scrape(season_page_url)
        teams = Scraper.scrape_teams_from_season(season_page_url)
        Team.create_from_array(teams)
    end

    def add_attributes(attributes_hash)
        attributes_hash.each do |k, v|
            self.send("#{k}=", v)
        end
    end

    def self.find_by_name(name)
        self.all.find{|team| team.name == name}
    end

    def self.reset
        self.all = []
    end

end