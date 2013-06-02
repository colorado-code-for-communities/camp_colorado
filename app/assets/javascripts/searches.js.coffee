jQuery ->
  $('.selection').chosen()

  $(document).on 'change', 'select', ->
    $('#new_search').submit()

  $(document).on 'click', '.query-icons .close-feature', (e) ->
    e.preventDefault()
    $li = $(this).closest('li')
    query_item_type = $li.data('query-item-type')
    index = $(".query-icons li[data-query-item-type=#{query_item_type}]").index($li)

    $dropdown = $("#search_#{query_item_type}_ids")
    $dropdown.find("option:selected:eq(#{index})").removeAttr("selected")
    $dropdown.change().trigger("liszt:updated")

  $(document).on 'mouseover', '.query-icons li', ->
    $(this).tooltip(placement: 'bottom')
    $(this).tooltip('show')

  $(document).on 'mouseout', '.query-icons li', ->
    $(this).tooltip('hide')
