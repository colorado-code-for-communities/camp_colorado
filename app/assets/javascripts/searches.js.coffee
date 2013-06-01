jQuery ->
  $('.selection').chosen()

  $(document).on 'change', 'select', ->
    $('#new_search').submit()
