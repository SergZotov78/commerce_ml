ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :company, :pricetype_id, :activated
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  scope :activated, as: 'Активные'
  scope :unactivated
  index do
    column :company
    column :email
    column :pricetype
    actions
  end

  form do |f|
    f.inputs 'Инфо пользователя' do
      f.input :company
    end
    f.inputs 'Доступ к приложению и просмотр цен' do
      f.input :pricetype, label: 'Выберите тип цены'
      f.input :activated, label: 'Активен?'
    end
    f.actions
  end

end
