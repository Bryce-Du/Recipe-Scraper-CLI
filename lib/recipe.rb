class Recipe
    extend Concerns::Findable
    
    attr_accessor :name, :link
    attr_reader :instructions

    @@all = []

    def initialize (name)
        @name = name
        @instructions = []
    end
    def save
        @@all << self
    end
    def Recipe.create(name)
        new_recipe = Recipe.new(name)
        new_recipe.save
        new_recipe
    end
    
    def add_instructions(instruction_array)
        instruction_array.each do |instr|
            @instructions << instr.strip
        end
    end
    def add_ingredient(ingr_name, quantity = "1")
        ingr = Ingredient.find_or_create_by_name(ingr_name)
        RecipeIngredient.create(ingr, self, quantity)
    end

    def ingredients
        keys = RecipeIngredient.all.select{|key| key.recipe == self}
        #keys.collect{|key| key.ingredient}
    end

    def Recipe.all
        @@all
    end
    def Recipe.destroy_all
        @@all.clear
    end

end