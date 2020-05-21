class Api::BooksController < ApplicationController
  def index
    @books = Book.order('updated_at DESC')
  end

  def search
    logger.debug(params)
    @book = Book.find(params[:book_id])
    @libraries = Library.joins(:users).where({users: {id: params[:user_id]}})

    @lib_system_ids=""
    @libraries.each do |lib|
      @lib_system_ids << lib.systemid + ","
    end
    logger.debug(@lib_system_ids)
    query_params = URI.encode_www_form({appkey: ENV['BOOKS_API_KEY'],
                                        isbn: @book.ISBN13,
                                        systemid: @lib_system_ids,
                                        callback: 'no'})
    uri = URI.parse("http://api.calil.jp/check?#{query_params}")
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      http.open_timeout = 5
      http.read_timeout = 10
      http.get(uri.request_uri)
    end
    begin
      case response
      when Net::HTTPSuccess
        @result = JSON.parse(response.body)
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    end
    render json: @result
  end

  def show
    @book = Book.find(params[:id])
  end

  private
  # def book_params
  #   params.fetch(:userBook, {}).permit(
  #       :user_id, :book_id
  #   )
  # end
end
