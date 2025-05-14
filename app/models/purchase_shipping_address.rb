class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city,
                :block_number, :building, :phone_number, :token

  with_options presence: true do
    validates :postal_code,
              format: { with: /\A\d{3}-\d{4}\z/,
                        message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id,
              numericality: { other_than: 1, message: 'must be selected' }
    validates :city
    validates :block_number
    validates :phone_number,
              format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' },
              length: { in: 10..11, message: 'is too short' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(
      purchase_id: purchase.id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      block_number: block_number,
      building: building,
      phone_number: phone_number
    )
  end
end
