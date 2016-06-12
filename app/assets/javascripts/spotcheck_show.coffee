ready = ->

  # Set listener for hours_worked inputs
  $('.hours_worked').on 'input', ->
    hours_worked = $(this).val()
    id = $(this).attr('id')
    params = {spot: {hours_worked: hours_worked}}
    assignee_id = $(this).attr('assignee_id')
    total_elem = $('#total_hours_' + assignee_id)
    update_spot(id, params, total_elem)
    $(this).focusout ->
      if $(this).val() == ''
        $(this).val(0)
      $(this).unbind('focusout')


  # Set listener for hours_left inputs
  $('.hours_left').on 'input', ->
    hours_left = $(this).val()
    id = $(this).data('activity')
    params = {activity: {hours_left: hours_left}}
    update_activity(id, params)
    $(this).focusout ->
      if $(this).val() == ''
        $('input[data-activity=' + id + ']').each ->
          $(@).val(0)
      $(this).unbind('focusout')


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

  # Initial setting of the visible spots and toggle buttons according to the user's preference
  show_spots_init()

  $('#show_all_spots').click ->
    unless $(@).attr('class').includes('active')
      $(@).addClass('active')
      $(@).blur()
      $('#show_my_spots').removeClass('active')
      $('.not_affiliated_spot').each ->
        $(@).show()
      update_preferences(preferences: {show_all_spots: true})
    else
      return false



  $('#show_my_spots').click ->
    unless $(@).attr('class').includes('active')
      $(@).addClass('active')
      $(@).blur()
      $('#show_all_spots').removeClass('active')
      $('.not_affiliated_spot').each ->
        $(@).hide()
      update_preferences(preferences: {show_all_spots: false})
    else
      return false

      
  set_activity_title_width()

  set_spotcheck_title_width()

# Sets Activity column width based on longest activity title
set_activity_title_width = ->
  longest = 0
  $('.activity_title').each (i, activity) ->
    length = $(activity).html().length
    longest = length if length > longest
  $('.activity_title').css('width', (longest * 0.6) + 'em')


# Sets Activity column width based on longest activity title
set_spotcheck_title_width = ->
  longest = 0
  $('.spotcheck_title').each (i, spotcheck) ->
    length = $(spotcheck).text().length
    longest = length if length > longest
  $('.spotcheck_title').css('width', (longest * 0.5) + 'em')


$(document).ready(ready)
$(document).on('page:load', ready)
