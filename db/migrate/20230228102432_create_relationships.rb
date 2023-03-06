class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
  end
end
# integer 数値（整数） 
# follower_id フォローするユーザのid
# followed_id フォローされるユーザのid