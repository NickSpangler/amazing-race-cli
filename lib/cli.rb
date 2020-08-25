require_relative "./environment"
require 'io/console' 

class CLI
    
    def run
        CBS.reset_program
        puts ""
        puts "Welcome to The Amazing Race CLI emulator!".red
        puts "Teams are heading to the starting line.".yellow
        puts "You'd better hurry if you want to join them!".red
        puts ""
        puts "What season would you like to explore? You can enter 1 - 31."
        input = gets.strip
        if input.to_i.between?(1, 31)
            puts ""
            puts "Pack your bag, it's race time!".yellow
            puts "Flights are being scheduled...".red
            puts "Producers are hiding clues...".yellow
            CBS.big_bang(input)
            puts ""
            puts "#{Season.all[0].title.red} is about to start! Hit '#{"return".yellow}' when your bag is packed!"
            continue
            display_season
        else
            run
        end
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
        puts s.about.fit.red.gsub(/\[\d+\]/, "")
        puts ""
        puts "#{"Distance traveled:".yellow} #{s.distance.red}"
        puts "#{"Starting line:".yellow} #{s.start.red}"
        puts "#{"Finish line:".yellow} #{s.finish.red}"
        puts "#{"Air dates:".yellow} #{s.air_dates.red}"
        puts ""
        menu
    end

    def display_team(number)
        team = Team.all.find{ |team| team.finish == number }
        puts ""
        puts team.name.yellow.bold
        puts ""
        puts "#{"Relationship:".yellow} #{team.relationship.red}" unless team.relationship == nil
        puts "#{"Hometown:".yellow} #{team.hometown.red}" unless team.hometown == nil
        puts "#{"Occupation:".yellow} #{team.occupation.red}" unless team.occupation == nil
        puts "#{"Finished:".yellow} #{team.place.red}"
        puts ""
        puts team.about.strip.red.fit
        puts ""
        puts "For more info about #{team.name}, enter '#{"More".yellow}'."
        puts "To run #{team.season.title} as #{team.name}, enter '#{"Race".yellow}'."
        puts "Or enter '#{"menu".yellow} or '#{"Exit".red}'."
        input = gets.strip.downcase
        case input
        when "more"
            more_info(team)
        when "race"
            run_race(team)
        when "exit"
            exit_program
        else
            menu
        end
        
    end

    def display_episode(number)
        e = Episode.all.find{|episode| episode.number == number}
        puts ""
        puts "Episode #{number} - #{e.title}".yellow.bold
        puts ""
        puts "#{"Air Date:".yellow} #{e.air_date.red}"
        puts ""
        e.route_info.each do |info|
            puts info.red.fit
            puts ""
            puts "Press any key to keep racing."
            puts ""
            continue
        end
        puts "To choose another episode, enter '#{"Episodes".yellow}'."
        puts "Or enter '#{"Menu".yellow}' or '#{"Exit".red}'." 
        input = gets.strip.downcase
        case input
        when "episodes"
            list_episodes
        when "exit"
            exit_program
        else
            menu
        end
    end

    def list_teams
        puts ""
        puts "#{Season.all[0].title} - Teams".red.bold
        puts ""
        Team.all.each.with_index(1){ |team, i| puts "#{"#{i}.".red} #{team.name.yellow}"}
        puts ""
        puts "Enter a #{"team number".yellow} to learn more about them."
        puts "Or enter '#{"Menu".yellow}' or '#{"Exit".red}'."
        input = gets.strip.downcase
        if input.to_i > 0 && input.to_i <= Team.all.count
            display_team(input.to_i)
        elsif input == "exit"
            exit_program
        else
            menu
        end
    end

    def list_episodes
        puts ""
        puts "#{Season.all[0].title} - Episodes".red.bold
        puts ""
        Episode.all.each.with_index(1){ |episode, i| puts "#{"#{i}.".red} #{episode.title.strip.yellow}"}
        puts ""
        puts "Enter an #{"episode number".yellow} to learn more about it."
        puts "Or enter '#{"Menu".yellow}' or '#{"Exit".red}'."
        input = gets.strip.downcase
        if input.to_i > 0 && input.to_i <= Episode.all.count
            display_episode(input.to_i)
        elsif input == "exit"
            exit_program
        else
            menu
        end
    end

    def more_info(team)
        puts ""
        puts team.name.yellow.bold
        puts ""
        puts "#{"Profile:".yellow} #{team.profile.red}".gsub(/\[\d+\]/, "").fit
        puts ""
        puts "#{"Post-Race:".yellow} #{team.post_race.red}".gsub(/\[\d+\]/, "").fit
        puts ""
        puts "#{"Trivia:".yellow} #{team.trivia.red}".gsub(/\[\d+\]/, "").fit
        puts ""
        puts "To run #{team.season.title} as #{team.name}, enter '#{"Race".yellow}'."
        puts "To choose another team, enter '#{"Teams".yellow}'."
        puts "Or enter '#{"Menu".yellow}' or '#{"Exit".red}'."
        input = gets.strip.downcase
        case input
        when "race"
            run_race(team)
        when "teams"
            list_teams
        when "exit"
            exit_program
        else
            menu
        end
    end

    def exit_program
        puts ""
        puts "Thank you for racing!".red.bold
        puts ""
    end

    def run_race(team)
        puts ""
        puts "Congratulations on being selected to run #{Season.all[0].title.red}, #{team.name}!"
        sleep(3)
        puts ""
        puts "You're standing at the starting line, #{Season.all[0].start.yellow}."
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
        puts "Congratulations on a race well run!".yellow.bold
        sleep(2)
        puts ""
        puts "You finished #{team.place.yellow}! You should be proud."
        sleep(3)
        puts ""
        puts "We hope you race again soon!"
        sleep (3)
        puts ""
        menu
    end

    def racing(team)
        Episode.all.each do |episode|
            if episode.teams.include?(team.name)
                puts "Episode #{episode.number} - #{episode.title}".yellow.bold
                puts ""
                episode.route_info.each do |info|
                    puts info.red.fit.gsub("#{team.name}", "You").gsub(/\[\d+\]/, "")
                    puts ""
                    puts "Press any key to keep racing."
                    puts ""
                    continue
                end
            end
        end
    end

    def menu
        puts "To see a list of teams, enter '#{"Teams".yellow}'."
        puts "To see a list of episodes, enter '#{"Episodes".yellow}'."
        puts "To pick a new season, enter '#{"Season".yellow}'."
        puts "If you are finished, enter '#{"Exit".red}'."
        input = gets.strip.downcase
        case input
        when "teams"
            list_teams
        when "episodes"
            list_episodes
        when "season"
            run
        when "exit"
            exit_program
        else
            menu
        end
    end

end