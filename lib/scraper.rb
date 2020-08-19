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
        doc = Nokogiri::HTML(open(team_page_url))
        team_attributes = {}

        team_attributes[:about] = "#{doc.css("#mw-content-text > p:nth-child(3)").text.strip}\n\n#{doc.css("#mw-content-text > p:nth-child(4)").text.strip}"
        team_attributes[:profile] = doc.css("#mw-content-text > p")[3..10].text
        team_attributes[:post_race] = doc.css("#mw-content-text > ul")[0].text
        team_attributes[:trivia] = doc.css("#mw-content-text > ul")[1].text
        team_attributes[:place] = doc.css("#mw-content-text > aside > section:nth-child(4) > div:nth-child(4) > div").text
        team_attributes[:hometown] = doc.css("#mw-content-text > aside > section:nth-child(3) > div:nth-child(2) > div").text
        team_attributes[:relationship] = doc.css("#mw-content-text > aside > section:nth-child(3) > div:nth-child(3) > div").text
        team_attributes[:occupation] = doc.css("#mw-content-text > aside > section:nth-child(3) > div:nth-child(4) > div").text
        team_attributes[:season] = doc.css("h2 span")[1].text
        team_attributes[:finish] = doc.css("#mw-content-text > aside > section:nth-child(4) > div:nth-child(4) > div").text[0...-2].to_i

        team_attributes
    end

    def self.scrape_episodes_from_season(season_page_url)
        doc = Nokogiri::HTML(open(season_page_url))
        episode_array = []
        tr_counter = 1
        while tr_counter <= 11
            episode = {
                :number=> tr_counter,
                :title=> doc.css("#mw-content-text > table")[1].css("tr")[tr_counter].css("td")[0].text,
                :episode_link=> doc.css("#mw-content-text > table")[1].css("tr")[tr_counter].css("td")[0].css("a").attr("href")
            }
            episode_array << episode
            tr_counter += 1
        end
        episode_array
    end

    def self.scrape_episode_page(episode_page_url)
        doc = Nokogiri::HTML(open(episode_page_url))
        episode_attributes = {}

        episode_attributes[:air_date] = doc.css("div.pi-data-value")[3].text

        counter = 0
        while counter < doc.css("div.tabbertab").count 
            episode_attributes["route_info_#{counter + 1}"] = doc.css("div.tabbertab")[counter].text
            counter += 1
        end

        episode_attributes
    end

end