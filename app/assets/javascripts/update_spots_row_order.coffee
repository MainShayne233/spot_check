ready = ->
  $('.sortable').each (index, elem) ->
    if $(elem).length > 0
      table_width = $(elem).width()
      cells = $('.table').find('tr')[0].cells.length
      desired_width = table_width / cells + 'px'

      $(elem).sortable(
        axis: 'y'
        items: '.item'
        cursor: 'move'

        sort: (e, ui) ->
          ui.item.addClass('active-item-shadow')
        stop: (e, ui) ->
          ui.item.removeClass('active-item-shadow')
          # highlight the row on drop to indicate an update
          ui.item.children('td').effect('highlight', {}, 1000)
        update: (e, ui) ->
          spot_id = ui.item.find('input').attr('id')
          position = ui.item.index() # this will not work with paginated items, as the index is zero on every page
          console.log position
          $.ajax(
            type: 'POST'
            url: '/spots/update_row_order'
            dataType: 'json'
            data: { spot: {id: spot_id, row_order_position: position } }
          )
      )

$(document).ready(ready)
$(document).on('page:load', ready)