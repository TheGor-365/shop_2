class ItemsController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token

  def index
    @items = Item.all
    # render body: @items.map { |item| "#{item.name} #{item.price}" }.join('; ')
  end

  def new; end

  def show
    unless (@item = Item.where(id: params[:id]).first)
      render body: 'Page not found', status: 404
    end
  end

  def create
    if @item = Item.create(items_params)
      redirect_to items_path
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.where(id: params[:id]).first
  end

  def update
    Item.where(id: params[:id]).update(items_params)

    redirect_to item_path
  end

  def destroy
    if @item = Item.where(id: params[:id]).first.destroy
      redirect_to items_path
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  private

  def items_params
    params.permit(:name, :price, :description, :real, :weight)
  end
end
