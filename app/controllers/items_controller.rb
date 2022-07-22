class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :set_item, only: [:edit, :show]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:image, :item_name, :explanation, :category_id, :status_id, :delivery_charge_id, :prefecture_id, :sending_day_id,
                                 :price).merge(user_id: current_user.id)
  end
end
