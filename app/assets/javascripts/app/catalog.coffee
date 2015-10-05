class Catalog
  @initialize: ->
    window.catalog = new Catalog

  constructor: ->
    do @handleShowCatalogMenu
    do @handleHideCatalogMenu
    do @handleGetChildCatalogItems
    do @handleGetParentCatalogItems

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
            "<button class='btn btn-default btn-block get_child' type='button' data-parent_id=\"#{button.parent_id}\" data-id=\"#{button.category_id}\">#{button.title}</button>"
          $('.catalog__left button:last').after(btns)
        else
          $(this).addClass('btn-danger')

  handleGetParentCatalogItems: ->
    $(document).on 'click', '.catalog__left .get_parent', ->
      parent_id = $(this).data 'parent_id'
      $.post '/products/' + parent_id + '/child_catalog', {}, (catalog) =>
        if catalog.success > 0
          btns = for button in catalog.content
            "<button class=\'btn btn-default btn-block get_child' type='button' data-parent_id=\"#{button.parent_id}\" data-id=\"#{button.category_id}\">#{button.title}</button>"
          $('.catalog__left').html(btns)
          if catalog.parent?
            $('.catalog__left button:first').before("<button class=\'btn btn-default btn-block get_parent' type='button' data-parent_id=\"#{catalog.parent.parent_id}\" data-id=\"#{catalog.parent.category_id}\">#{catalog.parent.title}</button>")



window.Catalog = Catalog