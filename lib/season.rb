class Season
    attr_accessor :name

    def initialize
        @number = "13"
        @teams = ["Nick & Starr", "Ken & Tina", "Dan & Andrew"]
        @episodes = [
            "Bees Are Much Calmer Than All This", 
            "Do You Like American Candy?", 
            "Did You Push My Sports Bra Off the Ledge?"]
        @about = "The Amazing Race 13 is the thirteenth season of the reality television show, The Amazing Race. It premiered on September 28, 2008 and ended on December 7, 2008 on CBS. The entire season was released on DVD (exclusively through Amazon.com) on April 8, 2014."
        @elimination_order = ["Anita & Arthur", "Anthony & Stephanie", "Mark & Bill", "Marisa & Brooke", "Aja & Ty", "Kelly & Christy", "Terence & Sarah", "Toni & Dallas", "Andrew & Dan", "Ken & Tina", "Nick & Starr"]
    end

    def self.scrape
        doc = Nokogiri::HTML(open("https://amazingrace.fandom.com/wiki/The_Amazing_Race_13"))
        binding.pry
    end

end 


#@number = doc.css(".page-header__title").text

#for below, look at how to get rid of footnotes
#@about = doc.css("p")[0].text

#use .each for 11 team names
#@teams name text = doc.css("font")[0..10].text
#for below, every odd number before "attr" from 1 (nick and starr) to 21 (anita and arthur) // and need to add "amazingrace.fandom" to beginning of "/wiki/Nick_%26_Starr"
#@teams link = doc.css("table a")[1].attr("href")

# EPISODES
#@first episode name = doc.css("table")[1].css("tr")[1].children[2].children.children.text
#@first episode link = doc.css("table")[1].css("tr")[1].children[2].children.css("a").attr("href").value
