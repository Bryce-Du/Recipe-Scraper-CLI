class RecipeIngredient
    attr_accessor :ingredient, :recipe

    @@all = []

    def initialize (ingredient, recipe)
        @ingredient = ingredient
        @recipe = recipe
    end
    def save
        @@all << self
    end
    def RecipeIngredient.create (ingredient, recipe)
        new_key = RecipeIngredient.new(ingredient, recipe)
        new_key.save
        new_key
    end

    def RecipeIngredient.all
        @@all
    end
    def RecipeIngredient.destroy_all
        @@all.clear
    end
end
