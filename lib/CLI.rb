class CLI
    def call
        Scraper.open_recipe("https://www.foodnetwork.com/recipes/recipes-a-z/b")
        puts ""
        puts "--Welcome to Recipe Scraper!--"
        puts ""
        puts "Enter 'help' for a list of commands."
        puts "Enter 'exit' to close app."
        response = ""
        until response == "exit"
            response = gets.strip.downcase
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
                puts ""
            end
        end
    end
    def help
        puts ""
        puts "For a list of recipes, enter 'recipes'."
        puts "To select a random recipe, enter 'random'."
        puts "To narrow recipes by ingredient, enter 'ingredient'."
        # puts rest of commands
        puts ""
    end
    def display_recipes(recipe_array)
        puts ""
        recipe_array.each_with_index {|recipe, index| puts "#{index+1}. #{recipe.name}"}
        puts ""
        puts "Please enter a number from 1 to #{recipe_array.length}."
        selection = gets.strip
        if selection.to_i.between?(1, recipe_array.length)
            select_recipe(selection, recipe_array)
        else
            puts "Invalid input"
            display_recipes(recipe_array)
        end
    end
    def select_recipe(selection, recipe_array = Recipe.all)
        selected = recipe_array[(selection.to_i)-1]
        if selected.ingredients.empty?
            Scraper.read_recipe(selected)
        end
        puts "  " + selected.name
        puts ""
        selected.ingredients.each {|ri| puts "  - #{ri.quantity}#{ri.ingredient.name}"}
        puts ""
        puts "-- Instructions --"
        selected.instructions.each.with_index(1) {|instr, index| puts "#{index}. #{instr}"}
        puts ""
        self.help
    end
    def random_recipe
        select_recipe(rand(Recipe.all.length-1)+1)
    end
    def ingr_filter
        puts "Please enter the name of the ingredient to filter by, or back to return to the main menu."
        ingr_name = gets.strip
        ingr = Ingredient.find_by_name_partial(ingr_name)

        if ingr_name == "back"
            puts ""
            self.help 
        elsif ingr != nil && ingr != [] && !ingr.empty?
            matched_recipes = []
            ingr.each do |i| 
                i.recipes.each do |j|
                    matched_recipes << j unless matched_recipes.include?(j)
                end
            end
            display_recipes(matched_recipes)
        else
            puts "No recipes found with that ingredient, try again"
            ingr_filter
        end
    end
end