ready = ->
  
  # Sets listener for new spot modal link

  $('#create_new_spot').click ->
    $('#new_spot_modal').modal('toggle')


  # Sets listener for new spotcheck modal link

  $('#create_new_spotcheck').click ->
    $('#new_spotcheck_modal').modal('toggle')
    modal_focus $("input[name='spotcheck[title]']")


  # Validates proper form input for spotcheck form
  $('#spotcheck_save').click ->
    input = $("input[name='spotcheck[title]']").val()
    if input.trim() == ''
      unless $('#errors').html() == error_div('Title cannot be blank')
        $('#errors').html(error_div('Title cannot be blank'))
      $("input[name='spotcheck[title]']").focus()
      return false
    spotchecks = []
    $('.spotcheck_title').each ->
      spotchecks.push $(@).html().trim()
    if $.inArray(input.trim(), spotchecks) != -1
      error_msg = "'" + input + "' spotcheck already exists"
      unless $('#errors').html() == error_div(error_msg)
        $('#errors').html(error_div(error_msg))
      $("input[name='spotcheck[title]']").focus()
      return false
    true

  # Removes input and error messages on spotcheck form close
  $('#new_spotcheck_modal').on 'hidden.bs.modal', ->
    $("input[name='spotcheck[title]']").val('')
    $('#errors').html('')


modal_focus = (target) ->
  setTimeout ->
    target.focus()
  , 200



$(document).ready(ready)
$(document).on('page:load', ready)