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
    it "すべての値が正しく入力されていれば保存できる" do
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
      expect(@order_address.errors.full_messages).to include("クレジットカード情報を入力してください")
    end

    it "Userが紐づいていなければ登録できない" do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Userを入力してください")
    end

    it "Itemが紐づいていなければ登録できない" do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Itemを入力してください")
    end

    it "郵便番号が空白では登録できない" do
      @order_address.post_code = " "
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
    end

    it "郵便番号が全角では登録できない" do
      @order_address.post_code = "１２３−４５６７"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("郵便番号には『-』(ハイフン)が必要です")
    end

    it  "都道府県名が未定では登録できない" do
      @order_address.prefecture_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("都道府県を正しく選択してください")
    end

    it  "市区町村が空白では登録できない" do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("市町村を入力してください")
    end

    it  "番地が空白では登録できない" do
      @order_address.house_num = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("番地を入力してください")
    end

    it "電話番号が空白では登録できない" do
      @order_address.phone_num = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
    end

    it "電話番号が全角では登録できない" do
      @order_address.phone_num = '０９０１２３４５６７８'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
    end

    it "電話番号が12桁以上では登録できない" do
      @order_address.phone_num = '1234567890123'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
    end

    it "電話番号が9桁以下では登録できない" do
      @order_address.phone_num = '12345678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
    end

    it "電話番号は数字のみでなければ登録できない（英数字混合）" do
      @order_address.phone_num = '090abcd1234'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
    end

    it "電話番号は数字のみでなければ登録できない（ハイフンあり）" do
      @order_address.phone_num = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
    end

    it "郵便番号は半角ハイフンを含む形でないと購入できない" do
      @order_address.phone_num = '090ー1234ー5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
    end
  end
end