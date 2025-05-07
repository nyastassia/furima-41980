require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.user = FactoryBot.create(:user)
    @item.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample1.png')), filename: 'sample.png',
                       content_type: 'image/png')
  end

  describe '出品機能' do
    context '出品できる場合' do
      it 'すべての項目が揃っていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'imageが空では登録できない' do
        @item.image = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'condition_idが空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'ship_cost_idが空では登録できない' do
        @item.ship_cost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship cost can't be blank")
      end

      it 'prefecture_idが空では登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'delivery_time_idが空では登録できない' do
        @item.delivery_time_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time can't be blank")
      end

      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が半角数字でなければ保存できない' do
        item = FactoryBot.build(:item, price: 'abc')
        item.valid?
        expect(item.errors.full_messages).to include('Price is not a number')
      end
      it '価格が300未満では保存できない' do
        @item = FactoryBot.build(:item, price: 299)
        @item.user = FactoryBot.create(:user)
        @item.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample1.png')), filename: 'sample.png',
                           content_type: 'image/png')
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が9_999_999より大きいと保存できない' do
        @item = FactoryBot.build(:item, price: 10_000_000)
        @item.user = FactoryBot.create(:user)
        @item.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample1.png')), filename: 'sample.png',
                           content_type: 'image/png')
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
    end
  end
end
