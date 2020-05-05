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
            else
                puts "Invalid command, please try again."
            end
        end
    end
    def help
        puts "For a list of recipes, enter 'recipes'"
        # puts rest of commands
    end
end