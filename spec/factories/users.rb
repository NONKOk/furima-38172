FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              { '1a' + Faker::Internet.password(min_length: 4)}
    password_confirmation {password}
    first_name_kanji      {'穂毛'}
    last_name_kanji       {'穂毛'}
    first_name_kana       {'ホゲ'}
    last_name_kana        {'ホゲ'}
    birthday              {'19881109'}
  end
end