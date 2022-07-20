FactoryBot.define do
  factory :item do
    # id
    id                  { 2 }

    # user_id
    user_id             { 2 }

    # イメージ
    image { Faker::Lorem.sentence }

    # 商品名
    item_name { Faker::Commerce.product_name }

    # 商品の説明
    explanation { Faker::Commerce.department }

    # カテゴリー
    category_id         { 2 }

    # 商品の状態
    status_id           { 2 }

    # 配送料の負担
    delivery_charge_id { 100 }

    # 販売元の地域
    prefecture_id { 2 }

    # 発送までの日数
    sending_day_id { 2 }

    # 価格
    price { 500 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/yubiwa.jpeg'), filename: 'yubiwa.jpeg')
    end
  end
end