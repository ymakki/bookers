class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
  end

# bookのcreate機能
  def create
    @book = Book.new(book_params)
    #@book = Book.new(@book_params)　←　こっちだと投稿時に成功でもエラー表示される
    if @book.save
      # createが成功したとき
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
      # redirect_to book_path(book.id)　　←　こっちだと投稿時に成功でもエラー表示される
    else
      # createが失敗したとき
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

# bookのupdate機能
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      # updateが成功したとき
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      #updateが失敗したとき
      render :edit
    end
  end

# bookのdestroy機能
  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end