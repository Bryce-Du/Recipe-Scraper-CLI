require "nokogiri"
require "open-uri"

class Scraper
    def open_index
        index_page = "https://www.foodnetwork.com/recipes/recipes-a-z/"
        alphabet = ("a".."z").to_a
        alphabet << "123"
        alphabet.each do |letter|
            open_recipe(index_page + letter)
        end
    end

    def open_recipe (page)
        letter_page = Nokogiri::HTML(open(page))
        recipe_css = letter_page.css("li.m-PromoList__a-ListItem a")
        recipe_pages = recipe_css.map {|link| link["href"]}
        recipe_pages.each do |recipe|
            read_recipe("https:" + recipe.to_s)
        end
    end

    def read_recipe (page)
        begin
            recipe_page = Nokogiri::HTML(open(page, {:redirect => false}))
            name = recipe_page.css(".o-AssetTitle__a-HeadlineText")[0].text
            recipe = Recipe.create(name)
            ingredients = []
            recipe_page.css(".o-Ingredients__a-Ingredient").each do |ingr_css|
                ingredients << ingr_css.text
            end
            ingredients.each {|ingr_name| recipe.add_ingredient(ingr_name)}
        rescue OpenURI::HTTPRedirect => redirect
        end
    end
end