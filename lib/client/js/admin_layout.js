Template.NavigationSidebar.rendered = function () {
    $('.collapsible').collapsible({
        accordion : true
    });
};

Template.AdminSidebar.rendered = function () {
    $(".treeview").tree();
};

Template.AdminSidebar.rendered = function () {
    $(".treeview").tree();
};

Template.Navigation.rendered = function() {
    $('.button-collapse').sideNav();
    $('.dropdown-button').dropdown({constrain_width: false, belowOrigin: true, hover: false, gutter: 10});

    var options = {
      offset: 0,
      topOffset: 150,
   // Fires once when element begins to come in from the top
        onTopIn: function( elm, distance_scrolled ) {
            console.log('onTopIn', elm, distance_scrolled);
        },

    // Fires once when element beings to go out at the top
        onTopOut: function( elm, distance_scrolled ) {
            console.log('onTopOut', elm, distance_scrolled);
        },

    // Fires once when element begins to come in from the bottom
        onBottomIn: function( elm, distance_scrolled ) {
            console.log('onBottomIn');
        },

    // Fires once when element begins to go out at the bottom
        onBottomOut: function( elm, distance_scrolled ) {
            console.log('onBottomOut');
        },

    // Fires once when element begins to go out at the bottom
        onScroll: function( elm, distance_scrolled ) {
            // console.log(elm, onScroll(elm, distance_scrolled));
        }
    };
    $("main").scrollfire(options);
};

Template.AdminHeader.rendered = function () {
    $("[data-toggle='offcanvas']").click(function(e) {
        e.preventDefault();

        //If window is small enough, enable sidebar push menu
        if ($(window).width() <= 992) {
            $('.row-offcanvas').toggleClass('active');
            $('.left-side').removeClass("collapse-left");
            $(".right-side").removeClass("strech");
            $('.row-offcanvas').toggleClass("relative");
        } else {
            //Else, enable content streching
            $('.left-side').toggleClass("collapse-left");
            $(".right-side").toggleClass("strech");
        }
    });
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

    $.fn.tree = function() {

        return this.each(function() {
            var btn = $(this).children("a").first();
            var menu = $(this).children(".treeview-menu").first();
            var isActive = $(this).hasClass('active');

            //initialize already active menus
            if (isActive) {
                menu.show();
                btn.children(".fa-angle-left").first().removeClass("fa-angle-left").addClass("fa-angle-down");
            }
            //Slide open or close the menu on link click
            btn.click(function(e) {
                e.preventDefault();
                if (isActive) {
                    //Slide up to close menu
                    menu.slideUp();
                    isActive = false;
                    btn.children(".fa-angle-down").first().removeClass("fa-angle-down").addClass("fa-angle-left");
                    btn.parent("li").removeClass("active");
                } else {
                    //Slide down to open menu
                    menu.slideDown();
                    isActive = true;
                    btn.children(".fa-angle-left").first().removeClass("fa-angle-left").addClass("fa-angle-down");
                    btn.parent("li").addClass("active");
                }
            });

            /* Add margins to submenu elements to give it a tree look */
            menu.find("li > a").each(function() {
                var pad = parseInt($(this).css("margin-left")) + 10;

                $(this).css({"margin-left": pad + "px"});
            });

        });

};


}(jQuery));