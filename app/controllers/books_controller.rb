class BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def create
    book = Book.new(author: 'Raditya Dika', title: 'Kambing Jantan')

    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unproccessable_entity
    end
    
  end

end
