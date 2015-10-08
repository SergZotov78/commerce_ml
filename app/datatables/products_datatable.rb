class ProductsDatatable
  delegate :params, :raw, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Product.count,
        iTotalDisplayRecords: products.total_entries,
        aaData: data
    }
  end

  private

  def data
    products.map do |product|
      [
          raw(product.title),
          raw(float_to_int product.amount),
          raw(product.costs.select{ |c| c.pricetype_id == '943956be-6614-11e3-ac3c-84c9b27e5984'}.first.price)
      ]
    end
  end

  def products
    @products ||= fetch_products
  end

  def fetch_products
    products = Product.willamount.order("#{sort_column} #{sort_direction}")
    if params[:checkCatalog]
      categories_id = Category.get_children_all(params[:checkCatalog])
      categories_id = (categories_id.instance_of? Array) ? categories_id.flatten.uniq : categories_id
      #TODO переделать импорт файлов для того чтобы сразу летели ид родительских категорий, или как по другому
      categories = categories_id.map{|cat_id| Category.find_by(category_id: cat_id)[:id] }
      products = products.by_categories_id(categories)
      # products = categories.inject{|_, cat| cat.products}.select{ |product| product.amount.present? }
    end
    products = products.page(page).per_page(per_page)
    if params[:sSearch].present?
      products = products.where("title like :search", search: "%#{params[:sSearch]}%")
    end
    products
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[title amount amount]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end


  def float_to_int data
    ( data == data.to_i ) ? data.to_i : data
  end
end