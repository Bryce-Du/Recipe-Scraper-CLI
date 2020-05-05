class IngredientRecipe
    attr_accessor :ingredient, :recipe

    @@all = []

    def initialize (ingredient, recipe)
        @ingredient = ingredient
        @recipe = recipe
    end
    def save
        @@all << self
    end
    def IngredientRecipe.create (ingredient, recipe)
        new_key = IngredientRecipe.new(ingredient, recipe)
        new_key.save
        new_key
    end

    def IngredientRecipe.all
        @@all
    end
    def IngredientRecipe.destroy_all
        @@all.clear
    end

    


end
