class OrdersController < ApplicationController

  def index
    @order = Order.new
    @item = Item.find(params[:item_id])
    @orderaddress = OrderAddress.new(order_params)
  end

  def create
    binding.pry
    @orderaddress = OrderAddress.new(order_params)
    if @orderaddress.valid?
      @orderaddress.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.permit(:post_code,:prefecture_id,:city,:house_num,:building,:phone_num).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
