require_relative "./environment"
class CBS
  SEASON_PREFIX = "https://amazingrace.fandom.com/wiki/The_Amazing_Race_13"
  PROFILE_PREFIX = "https://amazingrace.fandom.com/"

  def self.create_teams
    Team.create_teams_from_scrape(SEASON_PREFIX)
  end

  def self.add_team_info
    Team.all.each do |team|
      attributes = Scraper.scrape_team_page(PROFILE_PREFIX + team.profile_link)
      team.add_attributes(attributes)
    end
  end

  def self.create_season
    season_hash = Scraper.scrape_season_page(SEASON_PREFIX)
    Season.new(season_hash)
  end

  def self.create_episodes
    Episode.create_episodes_from_scrape(SEASON_PREFIX)
  end

  def self.add_episode_info
    Episode.all.each do |episode|
      attributes = Scraper.scrape_episode_page(PROFILE_PREFIX + episode.episode_link)
      episode.add_attributes(attributes)
    end
  end

  def self.associate
    Team.all.each do |team|
      team.season = Season.all[0]
      Season.all[0].teams << team
    end
    Episode.all.each do |episode|
      episode.season = Season.all[0]
      Season.all[0].episodes << episode
    end
  end

  def self.big_bang
    create_season
    create_teams
    add_team_info
    create_episodes
    add_episode_info
    associate
  end

  def self.reset_program
    Team.reset
    Episode.reset
    Season.reset
  end
end