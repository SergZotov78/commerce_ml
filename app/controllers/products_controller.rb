class ProductsController < ApplicationController

  def import
    if params[:token] == '99889988'
      ProductImporter.new.import
      CostImporter.new.import
    end
  end

  def index
    @products = Product.willamount
  end
end
