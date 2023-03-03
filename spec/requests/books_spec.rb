require 'rails_helper'

describe "Books API", type: :request do
    let(:first_author) { FactoryBot.create(:author, first_name: 'Rahmat', last_name: 'Aja', age: 18)}
    let(:second_author) { FactoryBot.create(:author, first_name: 'Chiko', last_name: 'Hakles', age: 19)} 
    

    # Contoh membuat metode GET / ambil data
    describe "GET /books/" do


        before do
            FactoryBot.create(:book, title:'1984', author: first_author)
            FactoryBot.create(:book, title:'Cara Ceroboh', author: second_author)
        end

        it 'returns all books' do
    
            get '/api/v1/books'
    
            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(2)
            expect(response_body).to eq(
                [    
                    {
                        'id' => 1,
                        'title' => '1984', 
                        'author_name' => 'Rahmat Aja',
                        'author_age' => 18
                    },
                    {
                        'id' => 2,
                        'title' => 'Cara Ceroboh', 
                        'author_name' => 'Chiko Hakles',
                        'author_age' => 19
                    }
                ]
            )  
        end 

        it 'return a subset of books based on pagination' do
            get '/api/v1/books', params: {limit: 1}

            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(1)
            expect(response_body).to eq(
                [    
                    {
                        'id' => 1,
                        'title' => '1984', 
                        'author_name' => 'Rahmat Aja',
                        'author_age' => 18
                    }
                ]
            )
        end

    end
    
    # Membuat contoh POST / kirim data
    describe 'POST /books' do
        it 'create a new book' do

            expect{
                post '/api/v1/books', params: { 
                    book: {title: 'Cara belajar'},
                    author:{first_name: 'Rahmat', last_name: 'Mulyana', age: '18'} 
                }
            }.to change {Book.count}. from(0).to(1)

            expect(response).to have_http_status(:created)
            expect(Author.count).to eq(1)
            expect(response_body).to eq(
                {
                    'id' => 1,
                    'title' => 'Cara belajar', 
                    'author_name' => 'Rahmat Mulyana',
                    'author_age' => 18
                }
            )  
        end  
    end

    # Membuat contoh delete
    describe 'DELETE /books/:id' do
        
        let!(:book) {FactoryBot.create(:book, title:'1984', author:first_author)}
        
        it 'delete a book' do
            expect {
                delete "/api/v1/books/#{book.id}"
            
            }.to change {Book.count}.from(1).to(0)

            expect(response).to have_http_status(:no_content)  
        end

    end
    
    
end
