class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence: true do
    validates :user
    validates :explanation
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
    validates :image
    validates :item_name

    # ジャンルの選択が「--」の時は保存できないようにする
    with_options numericality: { other_than: 1, message: "can't be blank" } do
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
  has_many :orders
end
