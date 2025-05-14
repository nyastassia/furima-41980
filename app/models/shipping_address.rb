class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :purchase
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :block_number
    validates :phone_number
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :phone_number, length: { in: 10..11, message: 'is too short' },
                           format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
end
