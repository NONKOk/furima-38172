require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入機能'
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    #@user.save	
    #@item.save
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    sleep 1
  end

  context '内容に問題ない場合' do
    it "priceがあれば保存ができる" do
      expect(@order_address).to be_valid
    end

    it '建物が空でも保存できる' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "tokenが空では登録できない" do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it "priceが空では保存ができない" do
      @order_address.price = nil
      @oorder_addressrder.valid?
      expect(@order_address.errors.full_messages).to include("Price can't be blank")
    end

    it "Userが紐づいていなければ登録できない" do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User must exist")
    end

    it "Itemが紐づいていなければ登録できない" do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item must exist")
    end

    it "郵便番号が空白では登録できない" do
      @order_address.post_code = " "
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
    end

    it "郵便番号が全角では登録できない" do
      @order_address.post_code = "１２３−４５６７"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Post code is out of setting range")
    end

    it  "都道府県名が未定では登録できない" do
      @order_address.prefecture_id = 0
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end

    it  "市区町村が空白では登録できない" do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it  "番地が空白では登録できない" do
      @order_address.house_num = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("House num can't be blank")
    end

    it "電話番号が空白では登録できない" do
      @order_address.phone_num = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num can't be blank")
    end

    it "電話番号が全角では登録できない" do
      @order_address.phone_num = '０９０１２３４５６７８'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num is out of setting range")
    end

    it "電話番号が12桁以上では登録できない" do
      @order_address.phone_num = '1234567890123'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num is too long (maximum is 12 characters)")
    end

    it "電話番号が9桁以下では登録できない" do
      @order_address.phone_num = '12345678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num is too short (minimum is 9 characters)")
    end

    it "電話番号は数字のみでなければ登録できない（英数字混合）" do
      @order_address.phone_num = '090abcd1234'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num can't be blank")
    end

    it "電話番号は数字のみでなければ登録できない（ハイフンあり）" do
      @order_address.phone_num = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num can't be blank")
    end

  end
end