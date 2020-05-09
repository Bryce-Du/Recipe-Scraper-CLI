module Concerns::Findable
    def find_by_name(name)
        self.all.detect{|s| s.name == name}
    end
  
    def find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def find_by_name_partial(name)
        self.all.select{|s| s.name.include?(name)}
    end
end