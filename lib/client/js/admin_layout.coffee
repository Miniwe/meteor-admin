Template.NavigationSidebar.rendered = ->
  $('.collapsible').collapsible accordion: true
  return

Template.Navigation.rendered = ->
  # @todo not used, use in future
  $('.button-collapse').sideNav()
  $('.dropdown-button').dropdown
    constrain_width: false
    belowOrigin: true
    hover: false
    gutter: 10
  options =
    offset: 0
    topOffset: 150
    onTopIn: (elm, distance_scrolled) ->
      console.log 'onTopIn', elm, distance_scrolled
      return
    onTopOut: (elm, distance_scrolled) ->
      console.log 'onTopOut', elm, distance_scrolled
      return
    onBottomIn: (elm, distance_scrolled) ->
      console.log 'onBottomIn'
      return
    onBottomOut: (elm, distance_scrolled) ->
      console.log 'onBottomOut'
      return
    onScroll: (elm, distance_scrolled) ->
      # console.log(elm, onScroll(elm, distance_scrolled));
      return
  # $("main").scrollfire(options);
  return

dataTableOptions =
  'aaSorting': []
  'bPaginate': true
  'bLengthChange': false
  'bFilter': true
  'bSort': true
  'bInfo': true
  'bAutoWidth': false
(($) ->
  'use strict'
  AutoForm.setDefaultTemplate 'materialize'
  return
) jQuery
