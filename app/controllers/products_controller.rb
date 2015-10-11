class ProductsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :import

  before_action :authenticate_user!, only: :index
  before_action :main_categories, only: :index
  before_action :find_id_catalog, only: :child_catalog
  before_action :user_activated, only: :index
  before_action :user_session, only: :index

  def import
    if params[:mode] == 'checkauth'
      render plain: "success\nImport\n998877"
    end
    if params[:mode] == 'init'
      render plain: "zip=no\nfile_limit=100000000"
    end
    if params[:type] == 'catalog' && params[:mode] == 'file'
      render plain: CommercemlSave.save(request ,params[:filename])
    end
    if params[:type] == 'catalog' && params[:mode] == 'import'
      render plain: CommercemlSave.check(params[:filename])
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

  def user_activated
    unless current_user.activated
      flash[:notice] = 'Вашу активность не подтвердил администратор'
      redirect_to edit_user_registration_path(current_user)
    end
  end

  def user_session
    session[:current_user_id] = current_user.id
  end
end
