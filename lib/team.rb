require_relative "./environment"
class Team
    extend Behavior::ClassMethods
    include Behavior::InstanceMethods
    
    attr_accessor :name, :profile_link, :about, :profile, :post_race, :trivia, :place, :hometown, :relationship, :occupation, :season, :finish, :season_number

    @@all = []

    def self.all
        @@all
    end

    def self.create_teams_from_scrape(season_page_url)
        teams = Scraper.scrape_teams_from_season(season_page_url)
        Team.create_from_array(teams)
    end

    def self.find_by_name(name)
        self.all.find{|team| team.name == name}
    end

end