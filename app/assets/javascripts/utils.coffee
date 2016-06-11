clone = (obj) ->
  if not obj? or typeof obj isnt 'object'
    return obj

  if obj instanceof Date
    return new Date(obj.getTime())

  if obj instanceof RegExp
    flags = ''
    flags += 'g' if obj.global?
    flags += 'i' if obj.ignoreCase?
    flags += 'm' if obj.multiline?
    flags += 'y' if obj.sticky?
    return new RegExp(obj.source, flags)

  newInstance = new obj.constructor()

  for key of obj
    newInstance[key] = clone obj[key]

  return newInstance


select_all = (el) ->
  if typeof window.getSelection != 'undefined' and typeof document.createRange != 'undefined'
    range = document.createRange()
    range.selectNodeContents el
    sel = window.getSelection()
    sel.removeAllRanges()
    sel.addRange range
  else if typeof document.selection != 'undefined' and typeof document.body.createTextRange != 'undefined'
    textRange = document.body.createTextRange()
    textRange.moveToElementText el
    textRange.select()
  return

key_is_num = (event) ->
  event.charCode < 58 and event.charCode > 47 or event.charCode == 0

error_div = (msg) ->
  "<div class='alert alert-danger'>" + msg + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>&times;</button></div>"
  
window.clone = clone
window.select_all = select_all
window.key_is_num = key_is_num
window.error_div = error_div