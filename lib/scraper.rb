require_relative "./environment"
class Scraper

    def self.scrape_season_page(season_page_url)
        scraped_season_page = Nokogiri::HTML(open(season_page_url))
        @teams = []
        @episodes = []

    end

    def self.scrape_teams_from_season(season_page_url)
        doc = Nokogiri::HTML(open(season_page_url))
        teams_array = []
        name_counter = 0
        link_counter = 1
        while name_counter <= 10 && link_counter <= 21
            team = {
                :name=> doc.css("font")[name_counter].text,
                :profile_link=> doc.css("table a")[link_counter].attr("href")
            }
            teams_array << team
            name_counter += 1
            link_counter += 2
        end
        teams_array
    end

    def self.scrape_team_page(team_page_url)
        team_attributes_hash = {}
        doc = Nokogiri::HTML(open(team_page_url))
        team_attributes[:about] = "#{doc.css("#mw-content-text > p:nth-child(3)").text.strip}\n\n#{doc.css("#mw-content-text > p:nth-child(4)").text.strip}"
        team_attributes[:key] = value
        team_attributes[:key] = value
        team_attributes[:key] = value
        team_attributes[:key] = value

        team_attributes_hash
    end

end