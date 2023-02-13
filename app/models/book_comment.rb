class BookComment < ApplicationRecord
    belongs_to :user
    belongs_to :book
    
    validates :comment, presence: true
end
# presenceは指定された属性が空でないことを確認します
# バリデーションは、正しいデータだけをデータベースに保存するために行われます