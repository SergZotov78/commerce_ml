class ProductsController < ApplicationController

  def import
    if params[:token] == '998899'
      ProductImporter.new("#{Rails.root}/public/upload/import.xml").import
      CostImporter.new("#{Rails.root}/public/upload/offers.xml").import
      @count_category = Category.count
    end
  end

  def index
    @categories = Category.count
    @products = Product.count
    @costs = Cost.count
    @pricetype = Pricetype.count
  end
end
