update_spot = (id, params, total_elem = null) ->
  arg_params = clone(params)
  if params.spot.hours_worked == ''
    arg_params.spot.hours_worked = 0
  $.ajax({
    type: 'PATCH',
    url: '/spots/' + id,
    data: arg_params,
    dataType: 'json',
    success: (data) ->
      if total_elem
        total_elem.html('<h4>Total Hours: ' + data + '</h4>')
  })

update_activity = (id, params) ->
  arg_params = clone(params)
  if params.activity.hours_left == ''
    arg_params.activity.hours_left = 0
  $.ajax({
    type: 'PATCH',
    url: '/activities/' + id,
    data: arg_params,
    dataType: 'json',
    success: ->
      $('input[data-activity=' + id + ']').each ->
        $(@).val(params.activity.hours_left)
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
