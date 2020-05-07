class RecipeIngredient
    attr_accessor :ingredient, :recipe, :quantity

    @@all = []

    def initialize (ingredient, recipe, quantity)
        @ingredient = ingredient
        @recipe = recipe
        @quantity = quantity
    end
    def save
        @@all << self
    end
    def RecipeIngredient.create (ingredient, recipe, quantity)
        new_key = RecipeIngredient.new(ingredient, recipe, quantity)
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
