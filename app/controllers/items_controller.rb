class ItemsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :find_item, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :is_admin?, only: [:edit]
  after_action :show_info, only: [:index]

  def index
    @items = Item.all
    # render body: @items.map { |item| "#{item.name} #{item.price}" }.join('; ')
  end

  def new; end

  def show; end

  def create
    item = Item.create(items_params)

    if item.persisted?
      redirect_to items_path
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @item.update(items_params)
      redirect_to item_path
    end
  end

  def destroy
    if @item.destroy.destroyed?
      redirect_to items_path
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def upvote
    @item.increment!(:votes_count)
    redirect_to items_path
  end

  def expensive
    @items = Item.where('price > 50')
    render 'index'
  end

  private

  def items_params
    params.permit(:name, :price, :description, :real, :weight)
  end

  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end

  def is_admin?
    true
    # render_403 unless params[:admin]
    # render json: 'Access Denied!', status: :forbidden unless  params[:admin]
  end

  def show_info
    puts 'Index endpoint'
  end
end
