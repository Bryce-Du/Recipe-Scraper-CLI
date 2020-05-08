class CLI
    def call
        puts "Loading Recipes, this should take a few minutes."
        Scraper.new.open_recipe("https://www.foodnetwork.com/recipes/recipes-a-z/p")
        puts "--Recipes loaded! Welcome to Recipe Scraper!--"
        puts "Enter 'help' for a list of commands."
        puts "Enter 'exit' to close app."
        response = ""
        until response == "exit"
            response = gets.strip
            if response == "exit"
                exit
            elsif response == "help"
                self.help
            elsif response == "recipes"
                self.display_recipes(Recipe.all)
            elsif response == "random"
                self.random_recipe
            elsif response == "ingredient"
                self.ingr_filter
            else
                puts "Invalid command, please try again."
            end
        end
    end
    def help
        puts "For a list of recipes, enter 'recipes'."
        puts "To select a random recipe, enter 'random'."
        puts "To narrow recipes by ingredient, enter 'ingredient'."
        # puts rest of commands
    end
    def display_recipes(recipe_array)
        recipe_array.each_with_index {|recipe, index| puts "#{index+1}. #{recipe.name}"}
        puts "Please enter a number from 1 to #{recipe_array.length}."
        selection = gets.strip
        select_recipe(selection, recipe_array)
    end
    def select_recipe(selection, recipe_array = Recipe.all)
        selected = recipe_array[(selection.to_i)-1]
        puts "  " + selected.name
        selected.ingredients.each {|ri| puts "  - #{ri.quantity}#{ri.ingredient.name}"}
        puts "-- Instructions --"
        selected.instructions.each_with_index {|instr, index| "#{index}. #{instr}"}
    end
    def random_recipe
        select_recipe(rand(Recipe.all.length-1)+1)
    end
    def ingr_filter
        puts "Please enter the name of the ingredient to filter by."
        ingr_name = gets.strip
        if ingr_name == "exit"
            exit
        end
        ingr = Ingredient.find_by_name(ingr_name)
        if ingr != nil
            display_recipes(ingr.recipes)
        else
            puts "No recipes found with that ingredient, try again"
            ingr_filter
        end
    end
end