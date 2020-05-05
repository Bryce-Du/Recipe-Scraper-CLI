class Ingredient
    attr_accessor :name

    @@all = []

    def initialize (name)
        @name = name
    end
    def save
        @@all << self
    end
    def Ingredient.create (name)
        new_ingr = Ingredient.new(name)
        new_ingr.save
        new_ingr
    end

    def Ingredient.all
        @@all
    end
    def Ingredient.destroy_all
        @@all.clear
    end

    def recipes
        IngredientRecipe.all.select{|key| key.ingredient == self}.recipe
    end
end