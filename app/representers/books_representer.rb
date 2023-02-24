class BooksRepresenter
    def initialize (books)
        @book = books
    end

    def as_json
        books.map do |book|
            {
                id: book.id,
                title: book.title,
                author_firts_name: book.author.firts_name,
                author_last_name: book.author.last_name,
                author_age: book.author.age
            }
    end

    private

    attr_reader :books
end