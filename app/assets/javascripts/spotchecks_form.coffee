ready = ->
  
  # Sets listener for new spot modal link

  $('#create_new_spot').click ->
    $('#new_spot_modal').modal('toggle')


  # Sets listener for new spotcheck modal link

  $('#create_new_spotcheck').click ->
    $('#new_spotcheck_modal').modal('toggle')
    modal_focus $("input[name='spotcheck[title]']")

modal_focus = (target) ->
  setTimeout ->
    target.focus()
  , 200



$(document).ready(ready)
$(document).on('page:load', ready)