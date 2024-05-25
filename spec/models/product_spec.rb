require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    before do
      @category = Category.create(name: 'Electronics')
end

it 'should save a product with all fields filled' do
  @product = Product.new(name: 'Phone', price: 1000, quantity: 10, category: @category)
  expect(@product).to be_valid
end

it 'should not save a product without a name' do
  @product = Product.new(price: 1000, quantity: 10, category: @category)
  expect(@product).to_not be_valid
end

it 'should not save a product without a price' do
  @product = Product.new(name: 'Phone', quantity: 10, category: @category)
  expect(@product).to_not be_valid
end

it 'should not save a product without a quantity' do
  @product = Product.new(name: 'Phone', price: 1000, category: @category)
  expect(@product).to_not be_valid
end

it 'should not save a product without a category' do 
  @product = Product.new(name: 'Phone', price: 1000, quantity: 10)
  expect(@product).to_not be_valid
end
end
end