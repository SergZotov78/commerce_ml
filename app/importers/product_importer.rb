class ProductImporter

  def initialize file
    f = File.open(file)
    @doc = Nokogiri::XML(f)
    f.close
  end

  def import
    create_products
    create_categories
  end

  private

  def create_products
    Product.delete_all
    @doc.xpath("//Каталог/Товары/Товар").each{ |product| create_product product }
  end

  def create_product product
    Product.create(
               category_id: product.css("Группы/Ид").text,
               title: product.css("Наименование").text,
               part_number: product.css("Артикул").text,
               full_text: product.css("ЗначенияРеквизитов/ЗначениеРеквизита")
                              .select { |text| text.css("Наименование").text == "Полное наименование" }
                              .first
                              .css("Значение").text

    )
  end

  def create_categories
    Category.delete_all
    @doc.xpath("//Классификатор/Группы/Группа").each{ |category| find_category category }
  end

  def find_category( category, parent_id = 0)
      create_category category, parent_id
      category.each{ |cat| find_category(cat, category.xpath("Ид").text) }
      find_category category.xpath("Группы/Группа") unless category.xpath("Группы/Группа").empty?
  end

  def create_category category, parent_id
    if category.xpath("Ид").count == 1
      Category.create(
          category_id: category.xpath("Ид").text,
          parent_id: parent_id,
          title: category.xpath("Наименование").text
      )
    end
  end
end