class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :book_id
      t.timestamps
    end
  end
end
# def change
  # create_table :テーブル名 do |t|
    # t.データ型 :カラム名
  # end
# end
# rails g migration Addカラム名(頭文字大文字)Toテーブル名(頭文字大文字、複数形) カラム名:データ型名
# integer 数値(整数)
      # t.integer :user_id「いいね」したユーザのID
      # t.integer :book_id「いいね」された投稿(読んだ本の感想)のID