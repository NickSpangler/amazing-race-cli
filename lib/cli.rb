require_relative "./environment"
require 'io/console' 

class CLI
    
    def run
        puts "Welcome to The Amazing Race!"
        puts "The teams are meeting at the starting line."
        puts "You'd better hurry if you want to join them!"
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

    def display_team(number)
        t = Team.all.find{ |team| team.finish == number }
        puts ""
        puts t.name
        puts ""
        puts "Relationship: #{t.relationship}"
        puts "Hometown: #{t.hometown}"
        puts "Occupation: #{t.occupation}"
        puts "Finished: #{t.place}"
        puts ""
        puts t.about
        puts ""
        puts "For more info about #{t.name}, enter 'More'."
        puts "To choose another team, enter 'Teams'."
        puts "To choose an episode to explore, enter 'Episodes'."
        input = gets.strip.downcase
        if input == "more"
            more_info(t)
        elsif input == "teams"
            list_teams
        elsif input == "episodes"
            list_episodes
        else
            display_team(number)
        end
        
    end

    def display_episode(number)
        e = Episode.all.find{|episode| episode.number == number}
        puts ""
        puts e.title
        puts ""
        puts "Air Date: #{e.air_date}"
        puts ""
        i = 1
        while i <= 10
            if e.send("route_info_#{i}") != nil
                puts e.send("route_info_#{i}")
                continue
                i += 1
            else
                i = 11
            end
        end
        puts "You made it to the end!"
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
        puts ""
        puts "For a list of teams to explore, enter 'Teams'."
        puts "To return to the season page, enter 'Season'."
        input = gets.strip.downcase
        if input.to_i.between?(1, 11)
            display_episode(input.to_i)
        elsif input == "teams"
            list_teams
        elsif input == "season"
            display_season
        else
            list_episodes
        end
    end

    def more_info(team)
        puts ""
        puts "Profile: #{team.profile}"
        puts ""
        puts "Post Race: #{team.post_race}"
        puts ""
        puts "Trivia: #{team.trivia}"
        puts ""
        puts "To choose another team, enter 'Teams'."
        puts "To choose an episode to explore, enter 'Episodes'."
        input = gets.strip.downcase
        if input == "teams"
            list_teams
        elsif input == "episodes"
            list_episodes
        else
            more_info(team)
        end
    end

end