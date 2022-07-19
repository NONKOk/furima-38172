class Item < ApplicationRecord
  with_options presence: true do
    validates :text
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'is out of setting range' }
    validates :image
    validates :name

    # ジャンルの選択が「--」の時は保存できないようにする
    with_options numericality: { other_than: 1 } do
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

  has_many :orders

end
