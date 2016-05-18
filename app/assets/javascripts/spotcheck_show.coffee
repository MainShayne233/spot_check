ready = ->

  # Set listener for hours_worked inputs
  $('.hours_worked').on 'input', ->
    id = $(this).attr('id')
    hours_worked = $(this).val()
    params = {spot: {hours_worked: hours_worked}}
    $.ajax({
      type: 'PATCH',
      url: '/spots/' + id,
      data: params,
      dataType: 'json'
    })


$(document).ready(ready)
$(document).on('page:load', ready)