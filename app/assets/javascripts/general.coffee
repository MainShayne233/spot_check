ready = ->

  # Sets listener for classed input to highlight upon being selected
  $('.select').click ->
    this.select()

$(document).ready(ready)
$(document).on('page:load', ready)