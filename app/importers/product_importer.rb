class ProductImporter

  def initialize file
    f = File.open(file)
    @doc = Nokogiri::XML(f)
    f.close
  end

  def import
    create_categories
    create_products
  end

  private

  def create_products
    Product.delete_all
    @doc.xpath("//Каталог/Товары/Товар").each{ |product| create_product product }
  end

  def create_product product
    category = Category.find_by(category_id: product.xpath("Группы/Ид").text)
    if category.nil?
      category = Category.find_by(category_id: '-')
      category = Category.create(title: '-', category_id: '-') if category.nil?
    end
    category.products.create(
               product_id: product.xpath("Ид").text,
               title: product.xpath("Наименование").text,
               part_number: product.xpath("Артикул").text,
               full_text: product.xpath("ЗначенияРеквизитов/ЗначениеРеквизита")
                              .select { |text| text.xpath("Наименование").text == "Полное наименование" }
                              .first
                              .xpath("Значение").text

    )
  end

  def create_categories
    Category.delete_all
    @doc.xpath("//Классификатор/Группы").each{ |category| find_category category }
  end

  def find_category category
      if category.xpath("Группа").present?
        category.xpath("Группа").each do |cat|
          Category.create(
              category_id: cat.xpath("Ид").text,
              parent_id: find_parent_cat(cat),
              title: cat.xpath("Наименование").text
          )
        end
        find_category category.xpath("Группа/Группы")
      end
  end

  def find_parent_cat(cat)
    (cat.parent.parent.xpath("Наименование").text == 'Классификатор (Основной каталог товаров)') ? "0" : cat.parent.parent.xpath("Наименование").text
  end

end