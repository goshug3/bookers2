class BooksController < ApplicationController
 
 before_action :baria_user, only: [:destroy, :update]
  
 def index
   @books = Book.all
   @user = User.find(current_user.id)
   @book = Book.new
 end
 
 def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   @user =@book.user
 if @book.save
   flash[:notice] = 'You have created book successfully.'
   redirect_to book_path(@book.id)
 else
   @books = Book.all
   render:index
 end
 end
 
 def show
   @book = Book.find(params[:id])
   @user = @book.user
   @newbook =Book.new
 end
 
 def destroy
    @book=Book.find(params[:id])
    @book.destroy
    @books = Book.all
    redirect_to books_path
 end

 def edit
  @book = Book.find(params[:id])
 if @book.user_id == current_user.id
    render:edit
 else
    redirect_to books_path
 end
 end

 def update
   @book =Book.find(params[:id])
 if @book.update(book_params)
   flash[:notice] = 'You have updated book successfully.'
   redirect_to book_path(@book.id)
 else
   render:edit
 end
 end

 private
 
 def user_params
   params.require(:user).permit(:name, :profile_image, :introduction)
 end
 def book_params
   params.require(:book).permit(:title, :body)
 end
 def baria_user
   unless Book.find(params[:id]).user.id.to_i == current_user.id
        redirect_to books_path
   end
 end
end