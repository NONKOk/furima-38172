class OrdersController < ApplicationController

  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @order = Order.new
    @orderaddress = OrderAddress.new(order_params)
  end

  def create
    #binding.pry
    @orderaddress = OrderAddress.new
    if @orderaddress.valid?
      pay_item
      @orderaddress.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.params.require(:order_address)permit(:post_code,:prefecture_id,:city,:house_num,:building,:phone_num).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: @orderaddress.token,    # カードトークン
      currency: 'jpy'                # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
