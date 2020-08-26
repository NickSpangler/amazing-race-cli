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