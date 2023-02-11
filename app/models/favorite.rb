class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :book
    validates_uniqueness_of :book_id, scope: :user_id
end
# 1:N の「N」側にあたるモデルに、belongs_to を記載する必要があります。user,bookに属する
# ユーザーは一つの投稿に一つしかいいねできないこと validates_uniqueness_of 
# 検証を簡単にこなすのがRailsに用意されたバリデーション(validatesメソッド)