ready = ->

  # Updates modal with error if spotcheck title is blank
  $('#spotcheck_save').click ->
    input = $("input[name='spotcheck[title]']").val()
    if input.trim() == ""
      $("input[name='spotcheck[title]']").focus()
      false

$(document).ready(ready)
$(document).on('page:load', ready)