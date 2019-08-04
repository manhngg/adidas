# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'change', '#area_region_id', ->
  $.ajax(
    type: 'GET'
    url: '/areas/prefs_select'
    data: {
      region_id: $(this).val()
    }
  ).done (data) ->
    $('#area_prefecture_id').html(data)

$(document).on 'change', '#q_region_id_eq', ->
  $.ajax(
    type: 'GET'
    url: '/areas/search_prefs_select'
    data: {
      region_id: $(this).val()
    }
  ).done (data) ->
    $('#q_prefecture_id_eq').html(data)
