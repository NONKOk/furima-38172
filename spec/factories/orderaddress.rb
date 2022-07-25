FactoryBot.define do
  factory :order_address do
    token {"tok_abcdefghijk00000000000000000"}
    post_code        {'123-4567'}
    prefecture_id   { 2 }
    city            {'京都'}
    house_num       {'西京区桂1-1'}
    birthday        {'桂ビル101'}
    phone_num       {'09012345678'}
  end
end