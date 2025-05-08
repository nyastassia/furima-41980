class ItemsController < ApplicationController
  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :image, :category_id,
                                 :condition_id, :ship_cost_id, :prefecture_id, :delivery_time_id).merge(user_id: current_user.id)
  end
end
