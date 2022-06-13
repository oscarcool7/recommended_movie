class Film
  attr_reader :director

  def initialize(title, director, year)
    @title = title
    @director = director
    @year = year
  end

  def to_s
    "#{@director} - #{@title} (#{@year})"
  end
end
