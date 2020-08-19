require_relative "./environment"
require 'io/console' 

class CLI
    
    def run
        puts "Welcome to The Amazing Race!"
        CBS.big_bang
        puts "Are you ready to explore Season 13? Hit 'return' to learn more!"
        continue
        display_season
    end
                                                                                                      
    def continue                                                                                                                                                                                                               
        STDIN.getch                                                                                                              
        print "            \r"                                                                                                             
    end 

    def display_season
        puts ""
        s = Season.all[0]
        puts s.title
        puts ""
        puts s.about
        puts ""
        puts "Distance traveled: #{s.distance}"
        puts "Starting line: #{s.start}"
        puts "Finish line #{s.finish}"
        puts "Air dates: #{s.air_dates}"
        teams_or_episodes
    end 

        def teams_or_episodes
            puts "For a list of teams to explore, enter 'Teams'."
            puts "For a list of episodes to explore, enter 'Episodes'."
            input = gets.strip.downcase
            case input
            when "teams"
                list_teams
            when "episodes"
                list_episodes
            else
                teams_or_episodes
            end
        end

        def list_teams
            puts ""
            Team.all.each.with_index(1){ |team, i| puts "#{i}. #{team.name}"}
            puts ""
            puts "Enter a team number to learn more about them."
            puts "For a list of episodes to explore, enter 'Episodes'."
            puts "To return to the season page, enter 'Season'."
            input = gets.strip.downcase
            if input.to_i.between?(1, 11)
                puts "You entered team ##{input.to_i - 1}."
            elsif input == "episodes"
                list_episodes
            elsif input == "season"
                display_season
            else
                list_teams
            end
        end

        def list_episodes
            puts ""
            Episode.all.each.with_index(1){ |episode, i| puts "#{i}. #{episode.title}"}
            puts ""
            puts "Enter an episode number to learn more about it."
            puts "For a list of teams to explore, enter 'Teams'."
            puts "To return to the season page, enter 'Season'."
            input = gets.strip.downcase
            if input.to_i.between?(1, 11)
                display_team(input.to_i - 1)
            elsif input == "teams"
                list_teams
            elsif input == "season"
                display_season
            else
                list_episodes
            end

            def display_team(number)
                t = Team.all.find{ |team| t.finish == number }
                puts ""
                puts t.name
                puts ""
                puts "Relationship: #{t.relationship}"
                puts "Hometown: #{t.hometown}"
                puts "Occupation: #{t.occupation}"
                puts "Finished: #{t.place}"
                
            end
        end
    
    #   def choose_season
    #     puts "Please select a season of The Amazing Race to explore. You can type a number between 1 and 31."
    
    #     input = gets.strip
    
    #     display_season(input)
    #   end
    
    #   def display_season(input)
    #     teams = ["Nick & Starr", "Ken & Tina", "Toni & Dallas", "Dan & Andrew"]
    #     episodes = ["Episode 1", "Episode 2", "Episode 3", "Episode 4"]
    
    #     puts "Here are the teams and episodes from Seaon #{input}."
    #     teams.each.with_index(1){|team, index| puts "#{index}. #{team}"}
    #     episodes.each{|episode| puts episode}
    #     puts "Select a team or episode to read more about it. Or enter 'new season' to choose a new season."
    #     puts "Or enter 'exit' to exit the program. "
    
    #     input = gets.strip.downcase
    #     case input
    #       when "new season"
    #         choose_season
    #       when "exit"
    #         exit_program
    #       else
    #         display_team_or_episode(input)
    #     end
    #   end
    
    #   def display_team_or_episode(input)
    #     puts "Here's everything you want to know about team/episode #{input}."
    #     puts "What would you like to do next? To list teams and episodes from this season, enter the season number."
    #     puts "To choose a different season, enter 'new season'."
    #     puts "To run the race as this team, enter 'Race!'"
    #     puts "To exit, enter 'exit'."
    #     input = gets.strip.downcase
    #     case input
    #       when "new season"
    #         choose_season
    #       when "race!"
    #         run_race
    #       when "exit"
    #         exit_program
    #       else
    #         display_season(input)
    #     end
    #   end
    
    #   def run_race
    #     puts "Figure out how to make this feature work."
    #     exit_program
    #   end
    
    #   def exit_program
    #     puts "Thanks for Racing!"
    #   end
end