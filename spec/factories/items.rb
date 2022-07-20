FactoryBot.define do
  factory :item do
    #id
    id                  {1} 

    #user_id
    user_id             {1}
 
    #イメージ
    image {Faker::Lorem.sentence}
    
    # 商品名
    item_name                { Faker::Commerce.product_name}
    
    # 商品の説明
    explanation                {Faker::Commerce.department}

    # カテゴリー
    category_id         {1}

    # 商品の状態
    status_id           {1}

    # 配送料の負担
    delivery_charge_id   {100}

    # 販売元の地域
    prefecture_id       {1}

    # 発送までの日数
    sending_day_id     {1}

    # 価格
    price             {300}
  end
end
FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name_kanji      { '穂毛' }
    last_name_kanji       { '穂毛' }
    first_name_kana       { 'ホゲ' }
    last_name_kana        { 'ホゲ' }
    birthday              { '19881109' }
  end
end
