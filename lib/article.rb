class Article

  # All Article instances created
  @@articles = []

  # Readonly Author, Magazine and Title
  attr_reader :author, :magazine, :title

  def initialize(author, magazine, title)
    @author = author
    @magazine = magazine
    @title = title

    @@articles << self
  end

  # Returns an array of all Article instances
  def self.all
    @@articles
  end

end
