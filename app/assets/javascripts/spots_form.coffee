ready = ->

  # Sets listener for spot save button

  $('#save-spot').click ->
    save_new_spot()

  #Initially hides the new activity form

  $("#new-activity").hide()

  # Sets listener on the activity dropdown to switch if Create New is selected
  # Clears input before showing it

  $("select[name='spot[activity_id]'").change ->
      if this.value == '0'
        $('.errors').html('')
        $("#pre-existing-activities").hide()
        $('#new-activity-input').val('')
        $("#new-activity").show()
        $('#new-activity-input').focus()


  # Sets the listener for the cancel button to toggle the activity input

  $("#cancel-activity").click ->
    cancel_activity()

  # sets listener for new activity save button and redirects to validation function

  $("#save-activity").click ->
    save_new_activity()

  # Alters enter key function from submitting spot form to submitting activity form

  $('#new-activity-input').on 'keypress', (e) ->
    if e.keyCode == 13
      save_new_activity()

  $('#new_spot').on 'keypress', (e) ->
    if e.keyCode == 13
      return false


  # Clears new spot form when closed
  $('#new_spot_modal').on 'hidden.bs.modal', ->
    $("select[name='spot[assignee_id]'").val('')
    $('.errors').html('')
    cancel_activity()


# Saves new activity and updates dropdown or displays errors for invalid input

save_new_activity = ->
  form = $('form#new_activity')
  $.ajax({
    type: 'POST',
    url: form.attr('action'),
    data: form.serialize(),
    dataType: 'JSON',
    success: (data) ->
      $("select[name='spot[activity_id]'").html('')
      data.activities.forEach (activity) ->
        $("select[name='spot[activity_id]'")
        .append($("<option></option>")
        .attr("value", activity[1])
        .text(activity[0]))
      $("#new-activity").hide()
      $("#pre-existing-activities").show()
      elem = "select[name='spot[activity_id]']>option:eq(" + (data['index'] + 2) + ")"
      $(elem).prop('selected', true)
    error: (data) ->
      error_msg = data.responseText
      unless $('.errors#activity').html() == error_msg
        $('.errors#activity').html(error_div(error_msg))
  })

save_new_spot = ->
  form = $('form#new_spot')
  $.ajax({
    type: 'POST',
    url: form.attr('action'),
    data: form.serialize(),
    dataType: 'JSON',
    success: (data) ->
      location.reload()
    error: (data) ->
      error_msg = data.responseText
      unless $('.errors#spot').html() == error_msg
        $('.errors#spot').html(error_div(error_msg))
  })


# Handles toggle the new activity form back to the select dropdown

cancel_activity = ->
  $("#new-activity").hide()
  $("#pre-existing-activities").show()
  $("select[name='spot[activity_id]']>option:eq(1)").prop('selected', true)
  $('.errors').html('')







$(document).ready(ready)
$(document).on('page:load', ready)
