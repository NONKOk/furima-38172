class OrderAddress

  include ActiveModel::Model
  # orderテーブルとaddressbookテーブルに保存したいカラム名を指定
  attr_accessor :post_code,:prefecture_id,:city,:house_num,:building,:phone_num,:user_id,:item_id

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token

    # カード情報
    validates :
    # 有効期限

    # セキュリティコード4桁

    # 配送先住所
    # 郵便番号
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  end

  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}
  
  # 市町村
  validates :city
  
  # 番地
  validates :house_num
  
  # 建物名
  validates :building
  
  # 電話番号
  validates :phone_num

  def save
    # 寄付情報を保存し、変数donationに代入する
    order = order.create(item_id: item_id, user_id: user_id)
    
    # 住所を保存する

    # donation_idには、変数donationのidと指定する
    Addressbooks.create(order: order, post_code: post_code, prefecture_id: prefecture_id, city: city, house_num: house_num, building: building, phone_num: phone_num)
  end
end