class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  # has_one :purchase
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_time
  belongs_to :prefecture
  belongs_to :ship_cost

  with_options presence: true do
    validates :item_name
    validates :description
    validates :price
    validates :image
    validates :user
    validates :category_id
    validates :condition_id
    validates :ship_cost_id
    validates :prefecture_id
    validates :delivery_time_id
  end

  validates :price, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9_999_999 }
  validates :category_id, :condition_id, :ship_cost_id, :prefecture_id, :delivery_time_id,
            numericality: { other_than: 1, message: "can't be blank" }
end
