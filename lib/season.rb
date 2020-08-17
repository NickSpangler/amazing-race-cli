class Season
    attr_accessor :name

    def initialize
        @teams = ["Nick & Starr", "Ken & Tina", "Dan & Andrew"]
        @episodes = [
            "Bees Are Much Calmer Than All This", 
            "Do You Like American Candy?", 
            "Did You Push My Sports Bra Off the Ledge?"]
        @number = "13"
        @about = "The Amazing Race 13 is the thirteenth season of the reality television show, The Amazing Race. It premiered on September 28, 2008 and ended on December 7, 2008 on CBS. The entire season was released on DVD (exclusively through Amazon.com) on April 8, 2014."
        @elimination_order = ["Anita & Arthur", "Anthony & Stephanie", "Mark & Bill", "Marisa & Brooke", "Aja & Ty", "Kelly & Christy", "Terence & Sarah", "Toni & Dallas", "Andrew & Dan", "Ken & Tina", "Nick & Starr"]
    end

    def self.scrape
        doc = Nokogiri::HTML(open(https://amazingrace.fandom.com/wiki/The_Amazing_Race_13))
    end

end 