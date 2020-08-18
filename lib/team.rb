class Team
    attr_accessor :name, :profile_link

    @@all = []

    def initialize(team_hash)
        team_hash.each do |key, value|
             self.send("#{key}=", value)
        end
        @@all << self
    end

end