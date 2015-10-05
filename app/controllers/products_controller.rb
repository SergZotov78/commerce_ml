class ProductsController < ApplicationController

  before_action :main_categories, only: [:index, :import]
  before_action :find_id_catalog, only: :child_catalog

  def import
    if params[:token] == '99889988'
      ProductImporter.new.import
      CostImporter.new.import
    end
  end

  def index
    @categories_main = Category.where(parent_id: 0)
    @products = Product.willamount
    respond_to do |format|
      format.html
      format.json { render json: ProductsDatatable.new(view_context) }
    end
  end

  def child_catalog
    catalogs = Category.where(parent_id: @cat_id[:id])
    parent = Category.find_by(category_id: @cat_id[:id])
    render json: { success: catalogs.size, content: catalogs, parent: parent }
  end

  private

  def find_id_catalog
    @cat_id = params.permit(:id)
  end

  def main_categories
    @categories_main = Category.where(parent_id: 0)
  end

end
