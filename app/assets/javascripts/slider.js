function setup_admin_buttons () {
  var icon_left = $('.menu-section .glyphicon-plus').offset().left;
  $('.admin_menu_button').each(function () {
    $(this).offset({
      top: $(this).offset().top,
      left: icon_left - 20
    });
  });
  $('.edit_button').each(function () {
    $(this).offset({
      top: $(this).offset().top,
      left: icon_left
    });
  });
}
function slider_ready (allow_touch) {
  var slideout = new Slideout({
    panel: $('#panel')[0],
    menu: $('#menu')[0],
    padding: 256,
    tolerance: 70,
    allow_touch: allow_touch
  });
  $('#menu_button').click(function () {
    slideout.toggle();
  });
  $('.menu').click(function (event_object) {
    var node_name = event_object.target.nodeName;
    if(node_name === 'A' || node_name === 'HEADER' || node_name === 'SPAN') {
      slideout.close();
    }
  });
  var scroll_location = 0;
  slideout.beforechange(function () {
    if(!slideout.isOpen()) {
      scroll_location = $(window).scrollTop();
      setTimeout(setup_admin_buttons, slideout._duration / 4);
    }
  });
  slideout.inchange(function () {
    if(!slideout.isOpen()) {
      var starting_offset = $('#site_contents').offset();
      $('#site_contents').offset({
        top: starting_offset.top - scroll_location,
        left: starting_offset.left
      });
    }
  });
  var original_offset = $('#site_contents').offset();
  slideout.change(function () {
    if(!slideout.isOpen()) {
      $('#panel').attr('style', '');
      $('#site_contents').offset(original_offset);
      $(window).scrollTop(scroll_location);
    }
  });
  $('#instructions_button').click(function () {
    setTimeout(function () {
      $('#instructions_modal').modal();
    }, 400);
  });
}
