class Scraper

    def self.scrape_season_page(season_page_url)
        scraped_season_page = Nokogiri::HTML(open(season_page_url))
        @teams = []
        @episodes = []

    end
end