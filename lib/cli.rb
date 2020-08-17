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
    puts "Select a team or episode to read more about it. Or enter 'new season' to choose a new season."
    puts "Or enter 'exit' to exit the program."

    input = gets.strip.downcase
    case input
      when "new season"
        choose_season
      when "exit"
        exit_program
      else
        display_team_or_episode(input)
    end
  end

  def display_team_or_episode(input)
    puts "Here's everything you want to know about team/episode #{input}."
    puts "What would you like to do next? To list teams and episodes from this season, enter the season number."
    puts "To choose a different season, enter 'new season'."
    puts "To run the race as this team, enter 'Race!'"
    puts "To exit, enter 'exit'."
    input = gets.strip.downcase
    case input
      when "new season"
        choose_season
      when "race!"
        run_race
      when "exit"
        exit_program
      else
        display_season(input)
    end
  end

  def run_race
    puts "Figure out how to make this feature work."
    exit_program
  end

  def exit_program
    puts "Thanks for Racing!"
  end

end