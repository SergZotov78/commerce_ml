class ProductsController < ApplicationController

  def import
    if params[:token] == '99889988'
      ProductImporter.new.import
      CostImporter.new.import
    end
  end

  def index
    @products = Product.willamount
    respond_to do |format|
      format.html
      format.json { render json: ProductsDatatable.new(view_context) }
    end
  end
end
