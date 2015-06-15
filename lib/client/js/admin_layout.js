Template.NavigationSidebar.rendered = function() {
  $('.collapsible').collapsible({
    accordion: true
  });
};

Template.Navigation.rendered = function() {
  $('.button-collapse').sideNav();
  $('.dropdown-button').dropdown({
    constrain_width: false,
    belowOrigin: true,
    hover: false,
    gutter: 10
  });

  var options = {
    offset: 0,
    topOffset: 150,
    onTopIn: function(elm, distance_scrolled) {
      console.log('onTopIn', elm, distance_scrolled);
    },
    onTopOut: function(elm, distance_scrolled) {
      console.log('onTopOut', elm, distance_scrolled);
    },
    onBottomIn: function(elm, distance_scrolled) {
      console.log('onBottomIn');
    },
    onBottomOut: function(elm, distance_scrolled) {
      console.log('onBottomOut');
    },
    onScroll: function(elm, distance_scrolled) {
      // console.log(elm, onScroll(elm, distance_scrolled));
    }
  };
  // $("main").scrollfire(options);
};

dataTableOptions = {
  "aaSorting": [],
  "bPaginate": true,
  "bLengthChange": false,
  "bFilter": true,
  "bSort": true,
  "bInfo": true,
  "bAutoWidth": false
};

(function($) {
  "use strict";

  AutoForm.setDefaultTemplate('materialize');

}(jQuery));