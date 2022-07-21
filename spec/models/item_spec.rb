require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品機能' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/yubiwa.jpeg')
    end

    # 正常テスト
    context '商品の出品ができる場合' do
      context '出品できるとき' do      
        it "すべての項目が入力されていれば、出品できる" do
          expect(@item).to be_valid
        end
      end
    end

    # 異常テスト
    context '出品に失敗するとき' do

      #出品者情報
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User can't be blank")
      end

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

      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = '---'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が空では登録できない' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '商品の状態が「---」では登録できない' do
        @item.status_id = '---'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      # 配送について
      it '配送料の負担が空では登録できない' do
        @item.delivery_charge_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end

      it '配送料の負担が「---」では登録できない' do
        @item.delivery_charge_id = '---'
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end

      it '発送元の地域が空では登録できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送元の地域が「---」では登録できない' do
        @item.prefecture_id = '---'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が空では登録できない' do
        @item.sending_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Sending day can't be blank")
      end

      it '発送までの日数が「---」では登録できない' do
        @item.sending_day_id = '---'
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
