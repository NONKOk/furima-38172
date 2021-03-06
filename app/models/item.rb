class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence: true do
    validates :explanation
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image
    validates :item_name

    # ジャンルの選択が「--」の時は保存できないようにする
    with_options numericality: { other_than: 1 , message: "を正しく選択してください" } do
      validates :category_id
      validates :status_id
      validates :delivery_charge_id
      validates :prefecture_id
      validates :sending_day_id
    end
  end

  belongs_to :category
  belongs_to :sending_day
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :status

  has_one_attached :image

  belongs_to :user
  has_one :order
end
