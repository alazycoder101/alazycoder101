class Author
  attr_accessor :name, :books

  def initialize  # constructor method
    @books = []
  end

  def write(book)
    @books << book
  end
end

class Book
  attr_accessor :title, :author
end

$book = Book.new
trace_var(:book) do |**|
  puts 'Book: ' + book.title
  puts book.author.name
end
$book = Book.new
book = Book.new
book.author = Author.new
book.author.name = "John Doe"
puts book.author.name

book.author.write(Book.new)
puts book.author.books

