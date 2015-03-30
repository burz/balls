$(function () {
  var slideout = new Slideout({
    'panel': $('#panel')[0],
    'menu': $('#menu')[0],
    'padding': 256,
    'tolerance': 70
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
});
