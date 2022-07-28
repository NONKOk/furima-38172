class OrdersController < ApplicationController

  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
    return redirect_to root_path if current_user.id == @item.user_id || !@item.order.nil?
  end

  def create
    
    @order_address = OrderAddress.new(order_params)
    #binding.pry
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :house_num, :building, :phone_num).
    merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end 
  ##item_id: params[:item_id]→item_id: @item.id

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
