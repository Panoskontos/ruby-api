module Api
    module V1
        class BooksController < ApplicationController
            # for create
            ALLOWED_DATA = %[title description rating].freeze
            
            # get all
            def index
                books = Book.all
                render json: books # , except: :title
            end

            # get one
            def show
                book = Book.find(params[:id])
                render json: book
            end
            
            # create one  
            def create
                data = json_payload.select {|k| ALLOWED_DATA.include?(k)}
                book = Book.new(data)
                if book.save
                    render json: book
                else
                    render json: {"error": "could not create it"}
                end
            end

            def update
               @book = Book.find(params[:id])
                @book.update(title:params[:title],description:params[:description],rating:params[:rating])
                render json: @book
            end

            # delete
            def destroy
                book = Book.find(params[:id])
                book.destroy
            end


        end
    end
end
