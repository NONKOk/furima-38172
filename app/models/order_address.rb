class OrderAddress

  include ActiveModel::Model
  # orderテーブルとaddressbookテーブルに保存したいカラム名を指定
  attr_accessor :post_code,:prefecture_id,:city,:house_num,:building,:phone_num,:user_id,:item_id,:token

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token

    # 配送先住所
    # 郵便番号
    validates :post_code, format: {with: /\A\d{3}[-]\d{4}\z/, message: "には『-』(ハイフン)が必要です" }

    #都道府県
    validates :prefecture_id, numericality: {other_than: 1, message: "を正しく選択してください" }
    
    # 市町村
    validates :city
  
    # 番地
    validates :house_num
    
    # 電話番号
    validates :phone_num, format: { with: /\A\d{10,11}\z/ } 

  end
  def save
    # 寄付情報を保存し、変数orderに代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    

    # order_idには、変数orderのidと指定する
    Address.create(order_id:order[:id], post_code: post_code, prefecture_id: prefecture_id, city: city, house_num: house_num, building: building, phone_num: phone_num)
  end
end