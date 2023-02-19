
class Magazine

  @@magazines = []

  # Creating getter and setter methods
  attr_accessor :name, :category

  # Magazine's constructor
  def initialize(name, category)
    self.name = name
    self.category = category

    # Keep track of all Instances created
    @@magazines << self
  end

  # Access all Magazine instances
  def self.all
    @@magazines
  end

  # Magazine's contributors
  def contributors
    # <<-SQL
    #   SELECT author FROM articles WHERE magazine = "knownmagazine"
    # SQL
    Article.all.filter { |article| article.magazine == self }.map { |article| article.author }.uniq
  end

  # Given a string of magazine's name, this method returns the first magazine object that matches
  def self.find_by_name(name)
    Magazine.all.find { |magazine| magazine.name == name }
  end

  # Returns an array of strings of the titles of all articles written for that magazine
  def article_titles
    Article.all.filter { |article| article.magazine.object_id == self.object_id }.map { |article| article.title }
  end

  # Returns an array of authors who have written more than 2 articles for the magazine
  # SUPER BONUS
  def contributing_authors
    authors = Article.all.filter { |article| article.magazine == self }.map { |article| article.author }
    authors.uniq.map.with_index { |author, index|
      {author: author, count: authors.filter { |au| author == au }.size}
    }.filter { |author| author[:count] > 1  }.map { |author| author[:author]}
  end
end

