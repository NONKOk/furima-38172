equire 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入機能'
  before do
    @user = FactoryBot.build(:user)
    @item = FactoryBot.build(:item)

    @user.save
    @item.save
    @orderaddress = FactoryBot.build(:orderaddress,user_id: @user.id, item_id: @item.id)
  end

  context '内容に問題ない場合' do
    it "priceがあれば保存ができること" do
      expect(@orderaddress).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "priceが空では保存ができないこと" do
      @orderaddress.price = nil
      @oorderaddressrder.valid?
      expect(@orderaddress.errors.full_messages).to include("Price can't be blank")
    end

    it "Userが紐づいていないと登録できない" do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postnum can't be blank")
    end

    it "Itemが紐づいていないと登録できない" do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postnum can't be blank")
    end
  end
end