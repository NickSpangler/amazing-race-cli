require_relative "./environment"
require 'io/console' 

class CLI
    
    def run
        puts ""
        puts "Welcome to The Amazing Race emulator!".red
        puts "Teams are converging on the starting line.".yellow
        puts "You'd better hurry if you want to join them!".red
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
        puts s.title.yellow.bold
        puts ""
        puts s.about.fit.red
        puts ""
        puts "#{"Distance traveled:".yellow} #{s.distance.red}"
        puts "#{"Starting line:".yellow} #{s.start.red}"
        puts "#{"Finish line:".yellow} #{s.finish.red}"
        puts "#{"Air dates:".yellow} #{s.air_dates.red}"
        puts ""
        teams_or_episodes
    end

    def display_team(number)
        team = Team.all.find{ |team| team.finish == number }
        puts ""
        puts team.name
        puts ""
        puts "Relationship: #{team.relationship}"
        puts "Hometown: #{team.hometown}"
        puts "Occupation: #{team.occupation}"
        puts "Finished: #{team.place}"
        puts ""
        puts team.about.fit
        puts ""
        puts "For more info about #{team.name}, enter 'More'."
        puts "To run #{team.season.title} as #{team.name}, enter 'Race'."
        puts "To choose another team, enter 'Teams'."
        puts "To choose an episode to explore, enter 'Episodes'."
        puts "If you are finished, enter 'Exit'."
        input = gets.strip.downcase
        case input
        when "more"
            more_info(team)
        when "race"
            run_race(team)
        when "teams"
            list_teams
        when "episodes"
            list_episodes
        when "exit"
            exit_program
        else
            display_team(number)
        end
        
    end

    def display_episode(number)
        e = Episode.all.find{|episode| episode.number == number}
        puts ""
        puts "Episode #{number} - #{e.title}"
        puts ""
        puts "Air Date: #{e.air_date}"
        puts ""
        i = 1
        while i <= 10
            if e.send("route_info_#{i}") != nil
                puts e.send("route_info_#{i}")
                puts ""
                puts "Press any key to keep racing."
                puts ""
                continue
                i += 1
            else
                i = 11
            end
        end
        puts "To choose another episode, enter 'Episodes'."
        puts "To see a list of teams, enter 'Teams'."
        puts "If you are finished, enter 'Exit'."
        input = gets.strip.downcase
        case input
        when "teams"
            list_teams
        when "episodes"
            list_episodes
        when "exit"
            exit_program
        else
            teams_or_episodes
        end
    end

    def teams_or_episodes
        puts "For a list of teams to explore, enter 'Teams'."
        puts "For a list of episodes to explore, enter 'Episodes'."
        puts "If you are finished, enter 'Exit'."
        input = gets.strip.downcase
        case input
        when "teams"
            list_teams
        when "episodes"
            list_episodes
        when "exit"
            exit_program
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
            display_team(input.to_i)
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
        puts "If you are finished, enter 'Exit'."
        input = gets.strip.downcase
        if input.to_i.between?(1, 11)
            display_episode(input.to_i)
        elsif input == "teams"
            list_teams
        elsif input == "season"
            display_season
        elsif input == "exit"
            exit_program
        else
            list_episodes
        end
    end

    def more_info(team)
        puts ""
        puts "Profile: #{team.profile}".fit
        puts ""
        puts "Post Race: #{team.post_race}".fit
        puts ""
        puts "Trivia: #{team.trivia}".fit
        puts ""
        puts "To run #{team.season.title} as #{team.name}, enter 'Race'."
        puts "To choose another team, enter 'Teams'."
        puts "To choose an episode to explore, enter 'Episodes'."
        puts "If you are finished, enter 'Exit'."
        input = gets.strip.downcase
        case input
        when "race"
            run_race(team)
        when "teams"
            list_teams
        when "episodes"
            list_episodes
        when "exit"
            exit_program
        else
            invalid_input
        end
    end

    def exit_program
        puts ""
        puts "Thank you for racing!"
        puts ""
    end

    def invalid_input
        puts "I'm sorry, I'm not sure what you mean."
        puts "For a list of teams, enter 'Teams'."
        puts "For a list of episodes, enter 'Episodes'."
        puts "If you are finished, enter 'Exit'."
        input = gets.strip.downcase
        case input
        when "teams"
            list_teams
        when "episodes"
            list_episodes
        when "exit"
            exit_program
        else
            invalid_input
        end
    end

    def run_race(team)
        puts ""
        puts "Congratulations on being selected to run #{Season.all[0].title}, #{team.name}!"
        sleep(3)
        puts ""
        puts "You're standing at the starting line, at #{Season.all[0].start}."
        sleep(3)
        puts ""
        puts "The world is waiting for you..."
        sleep(2)
        puts ""
        puts "GO!"
        sleep(2)
        puts ""
        racing(team)
        puts ""
        puts "Congratulations on a race well run!"
        sleep(2)
        puts ""
        puts "You finished #{team.place}! You should be proud."
        sleep(3)
        puts ""
        puts "We hope you race again soon!"
        sleep (2)
        puts ""
        puts "For a list of teams, enter 'Teams'."
        puts "For a list of episodes, enter 'Episodes'."
        puts "If you are finished, enter 'Exit'."
        input = gets.strip.downcase
        case input
        when "teams"
            list_teams
        when "episodes"
            list_episodes
        when "exit"
            exit_program
        else
            invalid_input
        end
    end

    def racing(team)
        Episode.all.each do |episode|
            if episode.teams.include?(team.name)
                puts "Episode #{episode.number} - #{episode.title}"
                puts ""
            i = 1
            while i <= 10
                if episode.send("route_info_#{i}") != nil
                    puts episode.send("route_info_#{i}").gsub("#{team.name}", "You")
                    puts ""
                    puts "Press any key to keep racing."
                    puts ""
                    continue
                    i += 1
                else
                    i = 11
                end
            end
        end
    end
end

end