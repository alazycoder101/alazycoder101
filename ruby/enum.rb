module Printable
  def print
    #code
  end
end

class Newspaper

  #This wil add the module's methods as instance methods to this class
  include Printable

  def headline
    #code
  end

  def sports_news
    #code
  end

  def world_news
    #code
  end

  def price
    #code
  end
end

class Book

  #This wil add the module's methods as instance methods to this class
  include Printable

  def title
    #code
  end

  def read_page(page_number)
    #code
  end

  def price
    #code
  end

  def total_pages
    #code
  end
end

enum status: { draft: 0, completed: 1, published: 2 }
if book.draft?
  puts 'darft'
elsif book.completed?
  puts 'completed'
elsif book.published?
  puts 'published'
end
