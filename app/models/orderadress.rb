class OrderAddress

  include ActiveModel::Model
  # orderテーブルとaddressbookテーブルに保存したいカラム名を指定
  attr_accessor :postnum,:prefecture_id,:city,:banchi,:tower,:phone,:user_id,:item_id,:order_id

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    attr_accessor :token

    # カード情報
    validates :
    # 有効期限

    # セキュリティコード4桁

    # 配送先住所
    # 郵便番号
    validates :post_code, format: {with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)"}
    # 市町村
    validates :city
  
    # 番地
    validates :house_num
    
    # 建物名
    validates :building

    # 電話番号
    validates :phone_num, numericality: { only_integer: true }

  end

  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
  
  # 電話番号
  validates :phone_num, length: { minimum: 10, maximum: 11 }# with: /\A\d{10,11}\z/（電話番号バリテーション）に変更するか？

  def save
    # 寄付情報を保存し、変数orderに代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    
    # 住所を保存する

    # order_idには、変数orderのidと指定する
    Addressbook.create(order_id:order[:id], post_code: post_code, prefecture_id: prefecture_id, city: city, house_num: house_num, building: building, phone_num: phone_num)
  end
end