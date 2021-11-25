require 'open-uri'
require 'json'

url = "http://tmdb.lewagon.com/movie/top_rated?api_key=%3Cyour_api_key%3E"
unseralized = URI.open(url).read
response = JSON.parse(unseralized)
results = response["results"]

img_base_url = "https://image.tmdb.org/t/p/w500"

puts "Cleaning movies database"
Movie.destroy_all

puts "Creating new movies"

results.first(5).each do |result|
  Movie.create!({
    title: result["title"],
    overview: result["overview"],
    poster_url: img_base_url+"#{result["backdrop_path"]}",
    rating: rand(0.0..10.0).round(1)
  })
end

puts "Created movies!"
