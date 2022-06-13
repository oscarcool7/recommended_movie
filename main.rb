require_relative "lib/film_collection"

URL = "https://www.kinonews.ru/top100/"
film_collection = FilmCollection.parse_from_url(URL)

puts "Программа «Фильм на вечер»"
puts
film_collection.directors.each.with_index(1) { |director, index| puts "#{index}: #{director}" }

user_input = 0

until user_input.between?(1, film_collection.directors.size)
  puts "Фильм какого режиссера вы хотите сегодня посмотреть?"
  user_input = $stdin.gets.to_i
end

chosen_director = film_collection.director_by_index(user_input - 1)
film_to_watch = film_collection.select_film_by_director(chosen_director).to_s

puts "\nИ сегодня вечером рекомендую посмотреть:"
puts film_to_watch
