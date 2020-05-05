class Recipe
    attr_accessor :name

    @@all = []

    def initialize (name)
        @name = name
    end
    def save
        @@all << self
    end
    def Recipe.create(name)
        new_recipe = Recipe.new(name)
        new_recipe.save
        new_recipe
    end

    def ingredients
        RecipeIngredient.all.select{|key| key.recipe == self}.ingredient
    end

    def Recipe.all
        @@all
    end
    def Recipe.destroy_all
        @@all.clear
    end

end