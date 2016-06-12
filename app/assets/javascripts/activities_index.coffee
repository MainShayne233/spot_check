ready = ->

# Sets active css for spotchecks link
  if $('body').attr('class').includes('activities')
    $('#activities_link').addClass('active')


$(document).ready(ready)
$(document).on('page:load', ready)