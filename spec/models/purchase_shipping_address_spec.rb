require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: @user.id, item_id: @item.id)
  end

  context '内容に問題がない場合' do
    it '全ての値が正しく入力されていれば保存できる' do
      expect(@purchase_shipping_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'postal_codeが空では保存できない' do
      @purchase_shipping_address.postal_code = ''
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeが「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
      @purchase_shipping_address.postal_code = '1111'
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include(
        'Postal code is invalid. Enter it as follows (e.g. 123-4567)'
      )
    end

    it 'prefecture_idが1では保存できない' do
      @purchase_shipping_address.prefecture_id = '1'
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include('Prefecture must be selected')
    end

    it 'cityが空では保存できない' do
      @purchase_shipping_address.city = ''
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("City can't be blank")
    end

    it 'block_numberが空では保存できない' do
      @purchase_shipping_address.block_number = ''
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Block number can't be blank")
    end

    it 'phone_numberが空では保存できない' do
      @purchase_shipping_address.phone_number = ''
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberは10桁以上11桁以内の半角数字のみ保存可能なこと' do
      @purchase_shipping_address.phone_number = '090-1234-5678'
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberが9桁では保存できない' do
      @purchase_shipping_address.phone_number = '123456789'
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include('Phone number is too short')
    end
  end
end
