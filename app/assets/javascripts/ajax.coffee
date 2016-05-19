update_spot = (id, params) ->
  $.ajax({
    type: 'PATCH',
    url: '/spots/' + id,
    data: params,
    dataType: 'json'
  })

window.update_spot = update_spot