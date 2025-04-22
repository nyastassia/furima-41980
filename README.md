# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------  | ------------------------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| nickname           | string  | null: false               |
| name(kanji)        | string  | null: false               |
| surname(kanji)     | string  | null: false               |
| name(katakana)     | string  | null: false               |
| surname(katakana)  | string  | null: false               |
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
| status           | integer    | null: false, default: 0                   |
| user_id          | references | null: false, foreign_key: true            |
| category_id      | integer    | null: false, foreign_key: true            |
| condition_id     | integer    | null: false, foreign_key: true            |
| ship_cost_id     | integer    | null: false, foreign_key: true            |
| ship_from_id     | integer    | null: false, foreign_key: true            |
| delivery_time_id | integer    | null: false, foreign_key: true            |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column           | Type       | Options                                   |
| -----------------| ---------- | ----------------------------------------- |
| user_id          | references | null: false, foreign_key: true            |
| item_id          | references | null: false, foreign_key: true            |
| created_at       | date       | null: false                               |

### Association
- belongs_to :user
- belongs_to :item
- has_one : shipping address

## shipping_address テーブル

| Column        | Type       | Options                                   |
| ------------- | ---------- | ----------------------------------------- |
| purchase_id   | references | null: false, foreign_key: true            |
| postal_code   | string     | null: false                               |
| prefecture_id | integer    | null: false, foreign_key: true            |
| city          | string     | null: false                               |
| block_number  | string     | null: false                               |
| building      | string     |                                           |
| phone_number  | string     | null: false                               |

### Association

- belongs_to : purchase

## ActiveHashモデル

以下のカラムは ActiveHash を使用しており、マスターデータとしてアプリ内に定義されています（DBに保存されません）。

| モデル名            | 対応カラム名           | 使用テーブル        | 備考         |
|--------------------|----------------------|------------------ |-------------|
| Prefecture         | prefecture_id        | shipping_address  | 都道府県一覧  |
| Category           | category_id          | items             | 商品カテゴリ  |
| Condition          | condition_id         | items             | 商品の状態    |
| ShippingCost       | ship_cost_id         | items             | 配送料負担    |
| ShipFrom           | ship_from_id         | items             | 発送元地域    |
| DeliveryTime       | delivery_time_id     | items             | 発送までの日数 |


## クレジットカード情報の取扱いについて

本アプリでは、クレジットカード情報はデータベースに保存されません。決済処理にはPay.jpという外部サービスを使用し、API連携を通じて安全に処理されます。

### 実装ポイント

購入時にユーザーが入力したクレジットカード情報は、トークン化されて外部APIに送信されます。

サーバー側には、トークンのみを保持し、カード番号・有効期限・セキュリティコード等は一切保存されません。