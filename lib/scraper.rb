require "nokogiri"
require "open-uri"

class Scraper
    def self.open_index
        index_page = "https://www.foodnetwork.com/recipes/recipes-a-z/"
        alphabet = ("a".."z").to_a
        alphabet << "123"
        alphabet.each do |letter|
            open_recipe(index_page + letter)
        end
    end

    def self.open_recipe (page)
        letter_page = Nokogiri::HTML(open(page))
        recipe_css = letter_page.css("li.m-PromoList__a-ListItem a")
        recipe_css.each do |recipe_link|
            recipe = Recipe.find_or_create_by_name(recipe_link.text)
            recipe.link = "https:" + recipe_link["href"]
        end
    end

    def self.read_recipe (recipe)
        begin
            recipe_page = Nokogiri::HTML(open(recipe.link, {:redirect => false}))
            # name = recipe_page.css(".o-AssetTitle__a-HeadlineText")[0].text
            # recipe = Recipe.find_or_create_by_name(name)
            ingr_as_css = recipe_page.css(".o-Ingredients__a-Ingredient")
            ingredients = []
            ingr_as_css.each do |ingr_css|
                ingr_text = ingr_css.text
                data = ingr_text.split(" ")
                quantity = ""
                if data.length == 1
                    ingr_name = data[0]
                elsif data[1] == "cup" || data[1] == "teaspoon" || data[1] == "tablespoon" || data[1] == "cups" || data[1] == "teaspoons" || data[1] == "tablespoons" || data[1] == "pound" || data[1] == "pounds" || data[1] == "ounce" || data[1] == "ounces" || data[1] == "oz" || data[1] == "oz." || data[1] == "lb" || data[1] == "lbs" 
                    quantity = "#{data[0]} #{data[1]} "
                    ingr_name = data.drop(2).join(" ")
                elsif /\d\/\d/ == data[0] || /\d+/ == data[0] || /\d\s\d\/\d/ == data[0]
                    quantity = "#{data[0]}"
                    ingr_name = data.drop(1).join(" ")
                else
                    ingr_name = ingr_text
                end
                recipe.add_ingredient(ingr_name, " #{quantity}")
            end
            instructions = recipe_page.css(".o-Method__m-Step").map{|instr| instr.text}
            recipe.add_instructions(instructions)
        rescue OpenURI::HTTPRedirect => redirect
        end
    end
end