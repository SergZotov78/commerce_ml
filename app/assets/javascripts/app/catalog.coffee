class Catalog
  @initialize: ->
    window.catalog = new Catalog

  constructor: ->
    do @handleShowCatalogMenu
    do @handleHideCatalogMenu

  handleShowCatalogMenu: ->
    $(document).on 'click', '.btn__catalog_menu', ->
      $('.catalog__box').removeClass('invisible')

  handleHideCatalogMenu: ->
    $(document).on 'click', '.catalog__opacity', ->
      $('.catalog__box').addClass('invisible')

window.Catalog = Catalog