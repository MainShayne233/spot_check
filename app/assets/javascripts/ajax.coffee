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


update_preferences = (params) ->
  $.ajax({
    type: 'POST',
    url: '/preferences/update'
    data: params,
    dataType: 'json'
  })

show_spots_init = ->
  $.ajax({
    type: 'GET'
    url: '/preferences/get',
    data: {preferences: {show_all_spots: true}}
    success: (data) ->
      active_btn = $(data['show_all_spots'] ? '#show_all_spots' : '#show_my_spots')
      if data['show_all_spots']
        $('#show_all_spots').addClass('active')
      else
        $('#show_my_spots').addClass('active')
        $('.not_affiliated_spot').hide()
  })


window.update_spot = update_spot
window.update_activity = update_activity
window.update_preferences = update_preferences
window.show_spots_init = show_spots_init
