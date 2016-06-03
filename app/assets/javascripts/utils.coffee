key_is_num = (event) ->
  event.charCode < 58 and event.charCode > 47 or event.charCode == 0

error_div = (msg) ->
  "<div class='alert alert-danger'>" + msg + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>&times;</button></div>"
  
window.key_is_num = key_is_num
window.error_div = error_div