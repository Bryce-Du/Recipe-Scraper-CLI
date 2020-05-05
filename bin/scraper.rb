require "nokogiri"
require "open-uri"

class Scraper
    attr_accessor :recipe_pages

    def initialize
        @recipe_pages = []
    end
    
    def get_full_index
        Nokogiri::HTML(open("https://www.foodnetwork.com/recipes/recipes-a-z")) # open the base recipes A-Z page
    end
    def get_alphabet_pages
        
    end
end