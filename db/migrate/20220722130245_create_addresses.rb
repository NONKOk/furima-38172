class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :order,foreign_key: true, null: false
      t.string :post_code,      null: false
      t.integer :prefecture_id, null: false
      t.string  :city,          null: false
      t.string  :house_num,     null: false
      t.string  :building
      t.string  :phone_num,     null: false

      t.timestamps
    end
  end
end
