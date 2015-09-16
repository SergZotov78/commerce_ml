class ProductsController < ApplicationController

  def index
    ProductImporter.new("#{Rails.root}/public/upload/import.xml").import
    @count_category = Category.count
  end
end
