# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------  | ------------------------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| nickname           | string  | null: false               |
| name_kanji         | string  | null: false               |
| surname_kanji      | string  | null: false               |
| name_katakana      | string  | null: false               |
| surname_katakana   | string  | null: false               |
| birthday           | date    | null: false               |


### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column           | Type       | Options                                   |
| ----------       | ---------- | ----------------------------------------- |
| item_name        | string     | null: false                               |
| description      | text       | null: false                               |
| price            | integer    | null: false                               |
| user             | references | null: false, foreign_key: true            |
| category_id      | integer    | null: false                               |
| condition_id     | integer    | null: false                               |
| ship_cost_id     | integer    | null: false                               |
| prefecture_id    | integer    | null: false                               |
| delivery_time_id | integer    | null: false                               |
### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column           | Type       | Options                                   |
| -----------------| ---------- | ----------------------------------------- |
| user             | references | null: false, foreign_key: true            |
| item             | references | null: false, foreign_key: true            |

### Association
- belongs_to :user
- belongs_to :item
- has_one : shipping_address

## shipping_address テーブル

| Column        | Type       | Options                                   |
| ------------- | ---------- | ----------------------------------------- |
| purchase      | references | null: false, foreign_key: true            |
| postal_code   | string     | null: false                               |
| prefecture_id | integer    | null: false                               |
| city          | string     | null: false                               |
| block_number  | string     | null: false                               |
| building      | string     |                                           |
| phone_number  | string     | null: false                               |

### Association

- belongs_to :purchase

