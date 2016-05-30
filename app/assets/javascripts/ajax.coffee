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

update_activity = (id, params) ->
  $.ajax({
    type: 'PATCH',
    url: '/activities/' + id,
    data: params,
    dataType: 'json',
    success: ->
      $('input[data-activity=' + id + ']').each (i, input) ->
        $(input).val(params.activity.hours_left)
  })


window.update_spot = update_spot
window.update_activity = update_activity
