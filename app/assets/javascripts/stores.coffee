# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'change', '#store_region_id', ->
  $.ajax(
    type: 'GET'
    url: '/stores/prefs_select'
    data: {
      region_id: $(this).val()
    }
  ).done (data) ->
    $('#store_prefecture_id').html(data)

$(document).on 'change', '#store_prefecture_id', ->
  $.ajax(
    type: 'GET'
    url: '/stores/areas_select'
    data: {
      prefecture_id: $(this).val()
    }
  ).done (data) ->
    $('#store_area_id').html(data)

$(document).on 'change', '#region-select-prefecture', ->
  $.ajax(
    type: 'GET'
    url: '/stores/search_prefs_select'
    data: {
      region_id: $(this).val()
    }
  ).done (data) ->
    $('#q_prefecture_id_eq').html(data)

$(document).on 'change', '#q_prefecture_id_eq', ->
  $.ajax(
    type: 'GET'
    url: '/stores/search_areas_select'
    data: {
      prefecture_id: $(this).val()
    }
  ).done (data) ->
    $('#q_area_id_eq').html(data)
