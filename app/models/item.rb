class Item < ApplicationRecord
  validates :price, numericality: { greater_than: 0, allow_nil: true }
  validates :name, :description, presence: true

  after_initialize { puts 'initialize' } # Item.new, Item.first
  after_save       { puts 'save' } # Item.create, Item.save
  after_create     { puts 'create' } # Item.create
  after_update     { puts 'update' } # Item.update
  after_destroy    { puts 'destroy' } # Item.last.destroy
end
