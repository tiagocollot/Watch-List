# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

Bookmark.delete_all
Movie.delete_all
List.delete_all

file = URI.open('https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg')
list = List.new(name: 'A great Foundation')
list.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
list.save


url = 'http://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)
# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
movies['results'].slice(0..30).each do |movie|
  Movie.create(title: movie['original_title'],
               overview: movie['overview'],
               poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
               rating: movie['vote_average'])
end

puts "#{Movie.count} created movies"
