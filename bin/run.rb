#!/usr/bin/env ruby

require_relative '../config/environment'

# krabby_patty = Recipe.create("krabby patty")
# krabby_patty_ingredients = ["bun", "lettuce", "tomato", "cheese", "patty", "pickles", "ketchup", "mustard", "secret formula"]
# krabby_patty_ingredients.each do |ingr_name|
#     krabby_patty.add_ingredient(ingr_name)
# end
# condiments_only = Recipe.create("condiments")
# condiments = ["ketchup", "mustard", "relish", "mayo"]
# condiments.each do |condiment|
#     condiments_only.add_ingredient(condiment)
# end

# krabby_patty.ingredients.each do |ingr|
#     puts ingr.name
# end
# puts "---"
# Ingredient.find_by_name("ketchup").recipes.each do |recipe|
#     puts recipe.name
# end
# puts "---"
# Ingredient.all.each do |ingr|
#     puts ingr.name
# end

Scraper.new.read_recipe("https://www.foodnetwork.com/recipes/a-great-seafood-burger-recipe-2012165")

CLI.new.call