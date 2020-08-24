require_relative "./environment"
class Season
    extend Behavior::ClassMethods
    include Behavior::InstanceMethods
    
    attr_accessor :title, :about, :distance, :start, :finish, :air_dates, :teams, :episodes

    @@all = []

    def initialize(hash)
        super
       @teams = []
       @episodes = []
    end

    def self.all
        @@all
    end

end 


#@number = doc.css(".page-header__title").text

#for below, look at how to get rid of footnotes
#@about = doc.css("p")[0].text

#use .each for 11 team names
#@teams name text = doc.css("font")[0..10].text

#team_links = [
#   doc.css("table a")[1].attr("href"),
#   doc.css("table a")[3].attr("href"),
#   doc.css("table a")[5].attr("href"),
#   doc.css("table a")[7].attr("href"),
#   doc.css("table a")[9].attr("href"),
#   doc.css("table a")[11].attr("href"),
#   doc.css("table a")[13].attr("href"),
#   doc.css("table a")[15].attr("href"),
#   doc.css("table a")[17].attr("href"),
#   doc.css("table a")[19].attr("href"),
#   doc.css("table a")[21].attr("href")
# ]


# EPISODES
#@first episode name = doc.css("table")[1].css("tr")[1].children[2].children.children.text
#@first episode link = doc.css("table")[1].css("tr")[1].children[2].children.css("a").attr("href").value
