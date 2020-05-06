class CLI
    def call
        puts "Welcome to Recipe Scraper!"
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
                self.display_recipes
            elsif response == "select"
                puts "Please enter a number from 1 to #{Recipe.all.length}."
                selection = gets.strip
                self.select_recipe(selection)
            else
                puts "Invalid command, please try again."
            end
        end
    end
    def help
        puts "For a list of recipes, enter 'recipes'"
        puts "To select a recipe by its listed number enter 'select'"
        # puts rest of commands
    end
    def display_recipes
        Recipe.all.each_with_index {|recipe, index| puts "#{index+1}. #{recipe.name}"}
    end
    def select_recipe(selection)
        selected = Recipe.all[(selection.to_i)-1]
        puts selected.name
        selected.ingredients.each {|ingr| puts "  - #{ingr.name}"}
    end

end