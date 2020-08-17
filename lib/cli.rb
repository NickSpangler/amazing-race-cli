class CLI
  BASE_PATH = "https://amazingrace.fandom.com/wiki/The_Amazing_Race_"

  def run
    puts "Welcome to The Amazing Race!"
    choose_season
  end

  def choose_season
    puts "Please select a season of The Amazing Race to explore. You can type a number between 1 and 31."

    input = gets.strip

    display_season(input)
  end

  def display_season(input)
    teams = ["Nick & Starr", "Ken & Tina", "Toni & Dallas", "Dan & Andrew"]
    episodes = ["Episode 1", "Episode 2", "Episode 3", "Episode 4"]

    puts "Here are the teams and episodes from Seaon #{input}."
    teams.each.with_index(1){|team, index| puts "#{index}. #{team}"}
    episodes.each{|episode| puts episode}
    puts "Select a team or episode to read more about it."

    input = gets.strip
    display_team_or_episode(input)
  end

  def display_team_or_episode(input)

  end

end