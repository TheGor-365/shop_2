require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'validates name' do
    should validate_presence_of :name
  end

  it 'validates price' do
    should validate_numericality_of :price
  end

  it 'has many' do
    should have_many :positions
    should have_many :comments
    should have_many :carts
  end

  it 'has one' do
    should have_one :image
  end

  context 'calculates price' do
    let!(:item_1) { create :item }
    let!(:item_2) { create :item }
    let!(:order)  { create :order }

    it 'calculates the price' do
      item_1.price = 10
      item_2.price = 20

      order = Order.new
      order.items << item_1
      order.items << item_2

      order.calculate_total
      expect(order.total).to be 30
    end
  end
end

