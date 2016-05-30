ready = ->

  # Set listener for hours_worked inputs
  $('.hours_worked').on 'input', ->
    hours_worked = $(this).val()
    if hours_worked == ''
      hours_worked = 0
      $(this).val(0)
    id = $(this).attr('id')
    params = {spot: {hours_worked: hours_worked}}
    assignee_id = $(this).attr('assignee_id')
    total_elem = $('#total_hours_' + assignee_id)
    console.log assignee_id
    update_spot(id, params, total_elem)

  # Set listener for hours_left inputs
  $('.hours_left').on 'input', ->
    hours_left = $(this).val()
    if hours_left == ''
      hours_left = 0
      $(this).val(0)
    id = $(this).data('activity')
    params = {activity: {hours_left: hours_left}}
    update_activity(id, params)


  # Set listener for work_accomplished inputs
  $('.work_accomplished').on 'input', ->
    work_accomplished = $(this).val()
    id = $(this).attr('id')
    params = {spot: {work_accomplished: work_accomplished}}
    update_spot(id, params)


  # Nulls keypress on hours worked inputs if not number
  $('.hours_worked').keypress (e) ->
    unless key_is_num(e)
      return false

  $('.hours_left').keypress (e) ->
    unless key_is_num(e)
      return false

  set_activity_title_width()

# Sets Activity column width based on longest activity title
set_activity_title_width = ->
  longest = 0
  $('.activity_title').each (i, activity) ->
    length = $(activity).html().length
    longest = length if length > longest
  $('.activity_title').css('width', (longest * 0.6) + 'em')


$(document).ready(ready)
$(document).on('page:load', ready)
