require_relative "film"
require "nokogiri"
require "open-uri"

class FilmCollection
  attr_reader :directors

  def self.parse_from_url(url)
    doc = Nokogiri::HTML(URI.open(url))
    films =
      doc.css("div[style='overflow:auto;']").map do |film_node|
        title = film_node.css(".titlefilm").text
        year = film_node.css("div.bigtext").text[-4..-1]
        director = film_node.css(".textgray")
                     .select { |div| div.css("span").text == "Режиссер:" }
                     .map { |div| div.text.gsub("Режиссер: ", "") }.join

        Film.new(title, director, year)
      end

    new(films)
  end

  def initialize(films)
    @films = films
    @directors = films.map(&:director).uniq
  end

  def director_by_index(index)
    @directors[index] if index.between?(0, @directors.size - 1)
  end

  def select_film_by_director(director)
    @films.select { |film| film.director == director }.sample
  end
end
