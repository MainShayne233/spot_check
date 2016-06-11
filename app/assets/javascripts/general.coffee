ready = ->

  # Sets listener for classed inputs to highlight upon being selected
  $('.select').click ->
    this.select()

$(document).ready(ready)
$(document).on('page:load', ready)