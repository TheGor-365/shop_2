class Item < ApplicationRecord
  validates :price, numericality: { greater_than: 0, allow_nil: true }
  validates :name, :description, presence: true

  # has_and_belongs_to_many :carts
  has_many :positions
  has_many :carts, through: :positions
  has_many :comments, as: :commentable

  after_initialize { puts 'initialize' } # Item.new, Item.first
  after_save       { puts 'save' } # Item.create, Item.save
  after_create     { puts 'create' } # Item.create
  after_update     { puts 'update' } # Item.update
  after_destroy    { puts 'destroy' } # Item.last.destroy
end
