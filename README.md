# README
# テーブル設計

## users テーブル

| Column             | Type   | Options                    |
| ------------------ | ------ | -------------------------- |
| nickname           | string | null: false                |
| first_name_kanji   | string | null: false                |
| last_name_kanji    | string | null: false                |
| first_name_kana    | string | null: false                |
| last_name_kana     | string | null: false                |
| email              | string | null: false , unique: true |
| encrypted_password | string | null: false                |
| birthday           | date   | null: false                |

### Association

- has_many :orders
- has_many :items

## items テーブル

| Column             | Type             | Options                        |
| ------------------ | ---------------- | ------------------------------ |
| user               | references       | null: false, foreign_key: true |
| item_name          | string           | null: false                    |
| explanation        | text             | null: false                    |
| category_id        | integer          | null: false                    |
| status_id          | integer          | null: false                    |
| delivery_charge_id | integer          | null: false                    |
| prefecture_id      | integer          | null: false                    |
| sending_day_id     | integer          | null: false                    |
| price              | integer          | null: false                    |

### Association

- belongs_to :user
- has_many :orders

## orders テーブル

| Column  | Type       | Options           |
| ------  | ---------- | ----------------- |
| user    | references | foreign_key: true |
| item    | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| order         | references | foreign_key: true |
| post_code     | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| house_num     | string     | null: false       |
| building      | string     |                   |
| phone_num     | string     | null: false       |

### Association

- belongs_to :order