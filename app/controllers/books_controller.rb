class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    # 新規投稿しようとするとエラーが起きます。
# bookのパラメータが不足しているというエラーですので、form周りを確認しましょう。
# まずbooks/index.html.erbを見てみると、
# <%= render 'books/form', book: @book %>
# と、フォームに@bookを使用しています。
# 次にbooksコントローラのindexアクションを見てみると、
# インスタンス変数が@booksしか定義されていません。
# ですので、新規投稿フォーム用の変数@book = Book.newを追記してあげる必要があります。
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end
# ターミナルのログを見ると、books#destroyを行おうとしてエラーになっています。
#books_controllerを確認すると、destroyではなく、deleteアクションになっています。
#この場合、(1) ルーティングに合わせ、アクション名をdestroyにする
#(2) アクション名に合わせ、deleteアクションのルーティングを設定するの2通りの解法がありますが、
#resourcesで生成されるものはdestroyアクションですので、
#(1)のアクション名を修正する方が自然になります。
#また、その下でもスペルミスがありますので、忘れず修正をしましょう。
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def ensure_correct_user
      @book = Book.find(params[:id])
      unless @book.user == current_user
        redirect_to books_path
      end
  end
end
# booksコントローラのストロングパラメータbook_paramsを確認すると、titleのみが許可されている状態です。
#ストロングパラメータは、データベースに保存してもいいものを許可するメソッドですので、bodyを追記してあげる必要があります