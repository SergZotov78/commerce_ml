class Category < ActiveRecord::Base
  has_many :products

  validates :category_id, :title, presence: true

  scope :get_children_all, ->cat_id do
    lists_cat_id = get_children(cat_id).map{ |catalog| catalog.category_id}
    if lists_cat_id.present?
      all_children_id = lists_cat_id.inject(Array.new){ |all,cat| all << get_children_all(cat) }
      lists_cat_id << all_children_id
      lists_cat_id
    else
      cat_id
    end
    lists_cat_id << cat_id
    lists_cat_id
  end

  scope :get_children, ->(category_id) { where('parent_id = ?', category_id) }
end
