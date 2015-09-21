class CostImporter

  def initialize file
    f = File.open(file)
    @doc = Nokogiri::XML(f)
    f.close
  end

  def import
    create_pricetypes
    create_costs
  end

  private

  def create_pricetypes
    Pricetype.delete_all
    @doc.xpath("//ПакетПредложений/ТипыЦен/ТипЦены").each{ |pricetype| create_pricetype pricetype }
  end

  def create_costs
    Cost.delete_all
    @doc.xpath("//ПакетПредложений/Предложения/Предложение").each do |cost|
      create_product_count(cost, cost.xpath("Ид").text) if cost.xpath("Количество").present?
      if cost.xpath("Цены/Цена").present?
        cost.xpath("Цены/Цена").each{ |c| create_cost( c, cost.xpath("Ид").text) }
      end
    end
  end

  def create_product_count(cost, product_id)
    product = Product.find_by(product_id: product_id)
    product.update(amount: cost.xpath("Количество").text)
  end

  def create_pricetype pricetype
    Pricetype.create(
                 pricetype_id: pricetype.css("Ид").text,
                 title: pricetype.css("Наименование").text
    )
  end

  def create_cost(cost, product_id)
    product = Product.find_by(product_id: product_id)
    product.costs.create(
            pricetype_id: cost.css("ИдТипаЦены").text,
            price: cost.css("ЦенаЗаЕдиницу").text,
            title: cost.css("Представление").text,
    )
  end
end