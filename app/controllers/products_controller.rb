class ProductsController < ApplicationController

  def import
    if params[:token] == '99889988'
      ProductImporter.import
      CostImporter.import
    end
  end

  def index
    @products = Product.willamount
  end
end
