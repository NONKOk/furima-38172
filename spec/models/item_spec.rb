require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品機能' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/yubiwa.jpeg')
    end

    # 正常テスト
    context '出品できるとき' do
      it '出品画像が投稿できるとき' do
        expect(@item).to be_valid
      end

      it '商品名が入力される' do
        @item.item_name = '商品名です。'
        expect(@item).to be_valid
      end

      it '商品の説明が入力される' do
        @item.explanation = '商品説明です。'
        expect(@item).to be_valid
      end

      # 商品の詳細
      it '商品のカテゴリーが選択される' do
        @item.category_id = '2'
        expect(@item).to be_valid
      end

      it '商品の状態が選択される' do
        @item.status_id = '2'
        expect(@item).to be_valid
      end

      # 配送について
      it '配送料の負担' do
        @item.delivery_charge_id = '2'
        expect(@item).to be_valid
      end

      it '発送元の地域' do
        @item.prefecture_id = '2'
        expect(@item).to be_valid
      end

      it '発送までの日数' do
        @item.sending_day_id = '2'
        expect(@item).to be_valid
      end

      # 販売価格
      it '価格が入力される' do
        @item.price = '500'
        expect(@item).to be_valid
      end
    end

    # 異常テスト
    context '出品に失敗するとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品説明が空では登録できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end

      # 商品の詳細
      it 'カテゴリーが空では登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が空では登録できない' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      # 配送について
      it '配送料の負担が空では登録できない' do
        @item.delivery_charge_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end

      it '発送元の地域が空では登録できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が空では登録できない' do
        @item.sending_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Sending day can't be blank")
      end

      # 価格
      it '価格が空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '全角数字では登録できない' do
        @item.price = '１２３４'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it '半角英数混合では登録できない' do
        @item.price = '1234abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it '半角英語だけでは登録できない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it '299円以下では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it '10,000,000以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
    end
  end
end
