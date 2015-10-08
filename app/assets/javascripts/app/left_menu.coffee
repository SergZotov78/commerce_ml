class Catalog
  @initialize: ->
    window.catalog = new Catalog

  constructor: ->
    do @handleShowCatalogMenu
    do @handleHideCatalogMenu
    do @handleGetChildCatalogItems
    do @handleGetParentCatalogItems
    do @handleChangeMenuChecked

  handleShowCatalogMenu: ->
    $(document).on 'click', '.btn__catalog_menu', ->
      $('.catalog__box').removeClass('invisible')

  handleHideCatalogMenu: ->
    $(document).on 'click', '.catalog__opacity', ->
      $('.catalog__box').addClass('invisible')

  handleGetChildCatalogItems: ->
    $(document).on 'click', '.catalog__left .get_child', ->
      id = $(this).data 'id'
      $.post '/products/' + id + '/child_catalog', {}, (catalog) =>
        if catalog.success > 0
          $(this).removeClass('get_child').addClass('get_parent')
          $('.catalog__left').html($(this))
          btns = for button in catalog.content
            "<div class=\"btn-group\"><button class='btn btn-default btn-block get_child' type='button' data-parent_id=\"#{button.parent_id}\" data-id=\"#{button.category_id}\">#{button.title}</button><input class=\"check__category\" type=\"checkbox\" aria-label=\"\"></div>"
          $('.catalog__left button:last').after(btns)
        else
          $(this).addClass('btn-danger')

  handleGetParentCatalogItems: ->
    $(document).on 'click', '.catalog__left .get_parent', ->
      parent_id = $(this).data 'parent_id'
      $.post '/products/' + parent_id + '/child_catalog', {}, (catalog) =>
        if catalog.success > 0
          btns = for button in catalog.content
            "<div class=\"btn-group\"><button class=\'btn btn-default btn-block get_child' type='button' data-parent_id=\"#{button.parent_id}\" data-id=\"#{button.category_id}\">#{button.title}</button><input class=\"check__category\" type=\"checkbox\" aria-label=\"\"></div>"
          $('.catalog__left').html(btns)
          if catalog.parent?
            $('.catalog__left button:first').before("<div class=\"btn-group\"><button class=\'btn btn-default btn-block get_parent' type='button' data-parent_id=\"#{catalog.parent.parent_id}\" data-id=\"#{catalog.parent.category_id}\">#{catalog.parent.title}</button><input class=\"check__category\" type=\"checkbox\" aria-label=\"\"></div>")

  handleChangeMenuChecked: ->
    $(document).on 'change', '.catalog__left [type="checkbox"]', ->
      $('.catalog__left [type="checkbox"]:checked').each ->
        $(this).prop('checked', false)
      $(this).prop('checked', true)
      $('#datatables').dataTable()._fnAjaxUpdate();
      $('.catalog__box').addClass('invisible')

window.Catalog = Catalog