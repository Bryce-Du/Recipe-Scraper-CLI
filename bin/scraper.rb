require "nokogiri"
require "open-uri"
# require "mechanize"

class Scraper
    attr_accessor :recipe_pages

    def initialize
        @recipe_pages = []
    end
    
    def read_recipe (page)
        recipe_page = Nokogiri::HTML(open(page))
        name = recipe_page.css(".o-AssetTitle__a-HeadlineText")[0].text
        recipe = Recipe.create(name)
        ingredients = []
        ingredient_css = recipe_page.css(".o-Ingredients__a-Ingredient")
        ingredient_css.each do |ingr_css|
            ingredients << ingr_css.text
        end
        ingredients.each {|ingr_name| recipe.add_ingredient(ingr_name)}
    end
end