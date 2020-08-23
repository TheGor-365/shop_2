class ItemsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :find_item, only: [:show, :edit, :update, :destroy, :upvote]
  after_action :show_info, only: [:index]

  def index
    @items = Item.all
    @items = @items.where('price >= ?', params[:price_from])        if params[:price_from]
    @items = @items.where('created_at >= ?', 1.day.ago)             if params[:today]
    @items = @items.where('votes_count >= ?', params[:votes_from]) if params[:votes_from]
    @items = @items.order(:id)

    @items = @items.includes(:image)

    # render body: @items.map { |item| "#{item.name} #{item.price}" }.join('; ')
  end

  def new; end

  def show; end

  def create
    item = Item.create(items_params)

    if item.persisted?
      flash[:success] = 'Item was created.'
      redirect_to items_path
    else
      flash.now[:error] = 'Please fill all fields correctly.'
      # render json: item.errors, status: :unprocessable_entity
      render :new
    end
  end

  def edit; end

  def update
    if @item.update(items_params)
      flash[:success] = 'Item was updated.'
      redirect_to item_path
    else
      flash.now[:error] = 'Please fill all fields correctly.'
      render :edit
    end
  end

  def destroy
    if @item.destroy.destroyed?
      flash[:success] = "Item was deleted"
      redirect_to items_path
    else
      flash[:error] = "Item wasn't deleted"
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

  def show_info
    puts 'Index endpoint'
  end
end
