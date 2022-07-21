FactoryBot.define do
  factory :item do
  association :user

    # 商品名
    item_name { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }

    # 商品の説明
    explanation { Faker::Lorem.characters(number: 100, min_alpha: 1, min_numeric: 1) }

    # カテゴリー
    category_id         { Faker::Number.between(from: 2, to: 11) }

    # 商品の状態
    status_id           { Faker::Number.between(from: 2, to: 6) }

    # 配送料の負担
    delivery_charge_id { Faker::Number.between(from: 2, to: 3) }

    # 販売元の地域
    prefecture_id { Faker::Number.between(from: 2, to: 48) }

    # 発送までの日数
    sending_day_id { Faker::Number.between(from: 2, to: 4) }

    # 価格
    price {Faker::Number.between(from: 300, to: 9999999)}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/yubiwa.jpeg'), filename: 'yubiwa.jpeg')
    end
  end
end