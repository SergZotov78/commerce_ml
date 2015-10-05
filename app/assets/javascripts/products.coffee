# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#datatables').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    responsive: true
    fnServerParams: (aoData) ->
      aoData.push
        'name': 'more_data'
        'value': 'my_value'
      return
    sAjaxSource: $('#datatables').data('source')