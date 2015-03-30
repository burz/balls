function setup_admin_buttons () {
  var icon_left = $('.menu-section .glyphicon-plus').offset().left;
  $('.admin_menu_button').each(function () {
    $(this).offset({
      top: $(this).offset().top,
      left: icon_left - 20
    });
  });
}
function slider_ready () {
  var slideout = new Slideout({
    panel: $('#panel')[0],
    menu: $('#menu')[0],
    padding: 256,
    tolerance: 70
  });
  var scroll_location = 0;
  var original_offset = { top: 0, left: 0 };
  $('#menu_button').click(function () {
    if(!slideout.isOpen()) {
      scroll_location = $(window).scrollTop();
      original_offset = $('#site_contents').offset();
      $('#site_contents').offset({
        top: original_offset.top - scroll_location,
        left: original_offset.left
      });
      setTimeout(setup_admin_buttons, slideout._duration / 4);
    }
    slideout.toggle();
  });
  $('.menu').click(function (event_object) {
    var node_name = event_object.target.nodeName;
    if(node_name === 'A' || node_name === 'HEADER' || node_name === 'SPAN') {
      slideout.close();
    }
  });
  slideout.change(function () {
    if(!slideout.isOpen()) {
      $('#panel').attr('style', '');
      $('#site_contents').offset(original_offset);
      $(window).scrollTop(scroll_location);
    }
  });
}
$(document).ready(slider_ready);
$(document).on('page:load', slider_ready);
