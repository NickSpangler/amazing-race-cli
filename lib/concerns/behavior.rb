module Behavior
    module InstanceMethods

        def initialize(hash)
            hash.each do |key, value|
                 self.send("#{key}=", value)
            end
            self.class.all << self
        end

        def add_attributes(attributes_hash)
            attributes_hash.each do |k, v|
                self.send("#{k}=", v)
            end
        end

    end

    module ClassMethods

        def create_from_array(array)
            array.each do |hash|
                self.new(hash)
            end
        end

        def reset
            self.all.clear
        end

    end
    
end