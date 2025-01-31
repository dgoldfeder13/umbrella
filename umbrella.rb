# Write your soltuion here!
require "http"
require "json"
require "dotenv/load"
pp "howdy"
pp "Where are you located?"

user_location = gets.chomp
#user_location = "Chicago"
pp user_location

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY") 

resp = HTTP.get(maps_url)

raw_response = resp.to_s
parsed_response = JSON.parse(raw_response)
results_hash = parsed_response.fetch("results")

first_result = results_hash.at(0)

geometry = first_result.fetch("geometry")
location = geometry.fetch("location")

lat = location.fetch("lat")
long = location.fetch("lng")
pp lat
pp long

pirate_url = "https://api.pirateweather.net/forecast/" + ENV.fetch("PIRATE_KEY") + "/" + lat.to_s + "," + long.to_s
pp pirate_url

pirate_resp = HTTP.get(pirate_url)
raw_response = pirate_resp.to_s
parsed_response = JSON.parse(raw_response)
current = parsed_response.fetch("currently")
pp "The Temperature is " + current.fetch("temperature").to_s + " degrees Farenheit"
