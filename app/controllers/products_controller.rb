class ProductsController < ApplicationController

  def import
    if params[:token] == '99889988'
      ProductImporter.new("#{Rails.root}/public/upload/import.xml").import
      CostImporter.new("#{Rails.root}/public/upload/offers.xml").import
      @count_category = Category.count
    end
  end

  def index
    @products = Product.willamount
  end
end
