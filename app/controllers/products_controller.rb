class ProductsController < ApplicationController

  def index
    ProductImporter.new("#{Rails.root}/public/upload/import.xml").import
    CostImporter.new("#{Rails.root}/public/upload/offers.xml").import
    @count_category = Category.count
  end
end
