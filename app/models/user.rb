class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  # Userモデルに対するbooksにバリデーションがかかってしまっています。
#booksカラムはありませんので、リレーション（has_many, belongs_to）を確認しましょう。
#user.rbを確認しますと、belongs_to :booksとなっており、
#つまり、User:Bookが、多:1になってしまっています。
#ですが、「1ユーザが複数の本を持つ」という関係のはずですので、正しくは逆です。
#よって、belongs_toではなく、has_manyが適切になります。
#なお、belongs_to :xxxとしますと、
#そのモデルのxxx_idカラムにバリデーションがかかるようになっています。
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}
  # バリデーションを設定したいカラムのモデルに
# validates :[そのカラム名], length: {maximum: 50}
# lengthとは属性の値の長さを検証しています。
# 多くのオプションがあり、様々な長さ制限を指定できます。
# この場合、文字数をmaxで50字までという設定になります。
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # through　経由する。
  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
# フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
# フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
# has_many :favorites, dependent: :destroy　アソシエーションの設定
# どのユーザーがいいねを押したか管理