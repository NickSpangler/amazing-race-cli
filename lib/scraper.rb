require_relative "./environment"
class Scraper

    def self.scrape_season_page(season_page_url)
        doc = Nokogiri::HTML(open(season_page_url))
        season = {}

        season[:title] = doc.css("#PageHeader > div.page-header__main > h1").text
        season[:about] = doc.css("#mw-content-text > p:nth-child(3)").text
        season[:distance] = doc.css("#mw-content-text > aside > section:nth-child(3) > div:nth-child(6) > div").text
        season[:start] = doc.css("#mw-content-text > aside > section:nth-child(3) > div:nth-child(7) > div").text
        season[:finish] = doc.css("#mw-content-text > aside > section:nth-child(3) > div:nth-child(8) > div").text
        season[:air_dates] = doc.css("#mw-content-text > aside > section:nth-child(3) > div:nth-child(10) > div").text
 
        season
    end

    def self.scrape_teams_from_season(season_page_url)
        doc = Nokogiri::HTML(open(season_page_url))
        teams_array = []
        doc.css("table")[0].css("tr td a").each do |team|
            unless team.text =~ /The Amazing Race/ || team.text =~ /\d+/
                if team.text != "" && team.text != nil
                    team = {
                        :name=> team.text,
                        :profile_link=> team.attr("href")
                        }
                    teams_array << team
                end
            end
        end
        teams_array
    end

    def self.scrape_team_page(team_page_url)
        doc = Nokogiri::HTML(open(team_page_url))
        team_attributes = {}

        team_attributes[:about] = "#{doc.css("#mw-content-text > p:nth-child(3)").text.strip}\n\n#{doc.css("#mw-content-text > p:nth-child(4)").text.strip}"
        team_attributes[:profile] = doc.css("#mw-content-text > p")[3..10].text.strip
        team_attributes[:post_race] = doc.css("#mw-content-text > ul")[0].text if doc.css("#mw-content-text > ul")[0]
        team_attributes[:trivia] = doc.css("#mw-content-text > ul")[1].text if doc.css("#mw-content-text > ul")[1]
        team_attributes[:place] = doc.css("#mw-content-text > aside > section:nth-child(4) > div:nth-child(4) > div").text
        doc.css("div.pi-item").each do |item|
            if item.css("h3").text == "Hometown:"
                team_attributes[:hometown] = item.css("div.pi-data-value").text
            elsif item.css("h3").text == "Relation:"
                team_attributes[:relationship] = item.css("div.pi-data-value").text
            elsif item.css("h3").text == "Occupation:"
                team_attributes[:occupation] = item.css("div.pi-data-value").text
            end
        end
        team_attributes[:season_number] = doc.css("h2 span")[1].text
        team_attributes[:finish] = doc.css("#mw-content-text > aside > section:nth-child(4) > div:nth-child(4) > div").text[0...-2].to_i

        team_attributes
    end

    def self.scrape_episodes_from_season(season_page_url)
        doc = Nokogiri::HTML(open(season_page_url))
        episode_array = []
        tr_counter = 1
            doc.css("table.wikitable")[0].css("tr td a").each do |link|
                unless link.text =~ /^\[\d*\]/
                episode = {
                    :number=> tr_counter,
                    :title=> link.text,
                    :episode_link=> link.attr("href")
                }
                tr_counter += 1
                episode_array << episode
                end
            end
        episode_array
    end

    def self.scrape_episode_page(episode_page_url)
        doc = Nokogiri::HTML(open(episode_page_url))
        episode_attributes = {}

        episode_attributes[:air_date] = doc.css("div.pi-data-value")[3].text if doc.css("div.pi-data-value")[3] != nil
        episode_attributes[:last_team] = doc.css("table")[0].css("td").last.css("a").text
        episode_attributes[:elimination] = doc.css("span.name").last.text
        episode_attributes[:route_info] = []
        episode_attributes[:teams] = []

        doc.css("table")[0].css("td a").find_all do |element|
            if element.text != nil && element.text != "" && element.text != "►"
                episode_attributes[:teams] << element.text
            end
        end

        counter = 0
        while counter < doc.css("div.tabbertab").count
            episode_attributes[:route_info] << doc.css("div.tabbertab")[counter].text.strip
            counter += 1
        end

        episode_attributes
    end

end