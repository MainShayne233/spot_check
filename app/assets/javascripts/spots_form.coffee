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
    $("#new-activity").hide()
    $("#pre-existing-activities").show()
    $("select[name='spot[activity_id]']>option:eq(1)").prop('selected', true)


  # Submits ajax request for new activity, and updates the dropdown with the new activity

  $("#save-activity").click ->
    save_new_activity()


  # Alters enter key function from submitting spot form to submitting activity form

  $('#new-activity-input').on 'keypress', (e) ->
    if e.keyCode == 13
      save_new_activity()

  $('#new_spot').on 'keypress', (e) ->
    if e.keyCode == 13
      return false


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







$(document).ready(ready)
$(document).on('page:load', ready)