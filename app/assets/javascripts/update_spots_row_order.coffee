ready = ->

  $('.no_sort').mousedown ->
    false

  $('.no_sort').click ->
    select_all(this)


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
          if ui.item.attr('class').includes('spot_row')
            spot_id = ui.item.find('input').attr('id')
            position = ui.item.index() # this will not work with paginated items, as the index is zero on every page
            $.ajax(
              type: 'POST'
              url: '/spots/update_row_order'
              dataType: 'json'
              data: { spot: {id: spot_id, row_order_position: position } }
            )
          else if ui.item.attr('class').includes('activity_row')
            activity_id = ui.item.find('input').data('activity')
            position = ui.item.index() # this will not work with paginated items, as the index is zero on every page
            $.ajax(
              type: 'POST'
              url: '/activities/update_row_order'
              dataType: 'json'
              data: { activity: {id: activity_id, row_order_position: position } }
            )
      )

$(document).ready(ready)
$(document).on('page:load', ready)