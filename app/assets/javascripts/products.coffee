# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  mainTables = $('#datatables').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    responsive: true
    fnServerParams: (aoData) ->
      aoData.push
        'name': 'checkCatalog'
        'value': $('.catalog__left [type="checkbox"]:checked').parents('.btn-group').find('button').attr('data-id')
      return
    sAjaxSource: $('#datatables').data('source')
