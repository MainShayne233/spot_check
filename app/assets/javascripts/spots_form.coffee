ready = ->

  #Initially hides the new activity form

  $("#new-activity").hide()


  # Sets listener on the activity dropdown to switch if Create New is selected
  # Clears input before showing it

  $("select[name='spot[activity_id]'").change ->
      if this.value == '0'
        $("#pre-existing-activities").hide()
        $('#new-activity-input').val('')
        $("#new-activity").show()
        $('#new-activity-input').focus()


  # Sets the listener for the cancel button to toggle the activity input

  $("#cancel-activity").click ->
    cancel_activity()

  # sets listener for new activity save button and redirects to validation function

  $("#save-activity").click ->
    validate_new_activity()

  # Alters enter key function from submitting spot form to submitting activity form

  $('#new-activity-input').on 'keypress', (e) ->
    if e.keyCode == 13
      validate_new_activity()

  $('#new_spot').on 'keypress', (e) ->
    if e.keyCode == 13
      return false
      
      
  # Clears new spot form when closed
  $('#new_spot_modal').on 'hidden.bs.modal', ->
    $('#errors').html('')
    cancel_activity()

# Validates correct input for new activity form

validate_new_activity = ->
  input = $('#new-activity-input').val()
  if input.trim() == ''
    unless $('#errors').html() == error_div('Title cannot be blank')
      $('#errors').html(error_div('Title cannot be blank'))
    $('#new-activity-input').focus()
    return false
  activities = []
  $("select[name='spot[activity_id]'] > option").each ->
    activities.push($(@).html().trim())
  if $.inArray(input.trim(), activities) != -1
    error = "'" + input + "' activity already exists"
    unless $('#errors').html() == error_div(error)
      $('#errors').html(error_div(error))
    $('#new-activity-input').focus()
    return false
  save_new_activity()
  $('#errors').html('')


# Makes ajax request so submit new actvity, returns with list of activities, new activity, and its index
# Purges the select list's dropdown and creates every option again, including the new activity
# Sets the new activity

save_new_activity = ->
  title = $('#new-activity-input').val()
  params = {activity: {title: title} }
  $.ajax({
    type: 'PATCH',
    url: '/activities/new',
    data: params,
    dataType: 'json',
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
  })

cancel_activity = ->
  $("#new-activity").hide()
  $("#pre-existing-activities").show()
  $("select[name='spot[activity_id]']>option:eq(1)").prop('selected', true)
  $('#errors').html('')







$(document).ready(ready)
$(document).on('page:load', ready)