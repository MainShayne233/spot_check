update_spot = (id, params, total_elem = null) ->
  $.ajax({
    type: 'PATCH',
    url: '/spots/' + id,
    data: params,
    dataType: 'json',
    success: (data) ->
      if total_elem
        total_elem.html('Total Hours: ' + data)
  })
  

window.update_spot = update_spot