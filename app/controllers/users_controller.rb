class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
# この場合、ensure_correct_userメソッドのbefore_actionにeditを追加してあげる必要があります。
# before_actionによってeditのアクションを起こす前にensure_correct_userメソッドが働きます。
# ensure_correct_userについて詳しく解説すると
# unlessはifの反対で「もし〜でなければ」という意味になりますので
# unless @user == current_user
# もし@userとcurrent_user(ログインしているユーザー)が一致してなければ、という意味になります。
# 一致していなかった場合、ログインしているuserのshowページにリダイレクトする仕組みになっています。
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
      # プロフィール編集が成功した後のurlを確認しますと
# https://...amazonaws.com/users.1
# となっており、usersindexを表示しています。
# users.1は余分に引数を渡しているときにこのように表示されます。
# users_pathはindexページですのでid(引数)は不要ですが、(@user)が渡されてしまっています。
# 今回は見本のBookers通りに詳細ページにリダイレクトしたいため、user_path(@user)が適切です。
    else
      # 今回はrenderの指定がshowページになってしまっているため、showではなくeditに書き換える必要があります。
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
