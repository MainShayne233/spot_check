ready = ->
  
  # Sets listener for new spot modal link

  $('#create_new_spot').click ->
    $('#new_spot_modal').modal('toggle')


  # Sets listener for new spotcheck modal link

  $('#create_new_spotcheck').click ->
    $('#new_spotcheck_modal').modal('toggle')
    modal_focus $("input[name='spotcheck[title]']")

  # Sets listener for spotcheck save button
  $('#spotcheck_save').click ->
    spotcheck_submit()

  # Sets keypress listener for enter to trigger spotcheck submission
  $("input[name='spotcheck[title]']").on 'keypress', (e) ->
    if e.keyCode == 13
      spotcheck_submit()

  # Removes input and error messages on spotcheck form close
  $('#new_spotcheck_modal').on 'hidden.bs.modal', ->
    $("input[name='spotcheck[title]']").val('')
    $('#errors').html('')


# Saves new spotcheck, or displays error if input is invalid

spotcheck_submit = ->
  form = $('form#new_spotcheck')
  $.ajax({
    type: 'POST',
    url: form.attr('action'),
    data: form.serialize(),
    dataType: 'JSON',
    success: ->
      location.reload()
    error: (data) ->
      error_msg = data.responseText
      unless $('#errors').html() == error_msg
        $('#errors').html(error_div(error_msg))
  })

modal_focus = (target) ->
  setTimeout ->
    target.focus()
  , 200
  




$(document).ready(ready)
$(document).on('page:load', ready)