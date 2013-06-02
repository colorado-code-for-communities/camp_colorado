jQuery ->
  $('.selection').chosen()

  $(document).on 'change', 'select', ->
    $('#new_search').submit()

  $(document).on 'click', '.query-icons .close-feature', (e) ->
    e.preventDefault()
    $li = $(this).parents('li')
    query_item_type = $li.data('query-item-type')
    id = $li.data('record-id')

    $dropdown = $("#search_#{query_item_type}_ids")
    $option = $dropdown.find("option[data-record-id='#{id}']")
    $option.removeAttr("selected")
    $dropdown.change().trigger("liszt:updated")

  $(document).on 'mouseover', '.query-icons li', ->
    $(this).tooltip(placement: 'bottom')
    $(this).tooltip('show')

  $(document).on 'mouseout', '.query-icons li', ->
    $(this).tooltip('hide')
