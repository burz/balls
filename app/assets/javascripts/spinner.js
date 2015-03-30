var spinner = null;
function start_spinner () {
  if(spinner === null) {
    var options = {
      lines: 13, // The number of lines to draw
      length: 20, // The length of each line
      width: 10, // The line thickness
      radius: 30, // The radius of the inner circle
      corners: 1, // Corner roundness (0..1)
      rotate: 0, // The rotation offset
      direction: 1, // 1: clockwise, -1: counterclockwise
      color: '#000', // #rgb or #rrggbb or array of colors
      speed: 1, // Rounds per second
      trail: 60, // Afterglow percentage
      shadow: false, // Whether to render a shadow
      hwaccel: false, // Whether to use hardware acceleration
      className: 'spinner', // The CSS class to assign to the spinner
      zIndex: 2e9, // The z-index (defaults to 2000000000)
      top: ($(window).scrollTop() + 200) + 'px', // Top position relative to parent
      left: '50%' // Left position relative to parent
    };
    spinner = new Spinner(options).spin($('#spinner_canvas')[0]);
  }
}
function stop_spinner () {
  if(spinner != null) {
    spinner.stop();
    spinner = null;
  }
}
function spinner_ready () {
  var spinner_canvas = $('#spinner_canvas');
  $(window).scroll(function () {
    spinner_canvas.stop().animate({
      'marginTop': ($(window).scrollTop() + 200) + "px"
    }, 'slow');
  });
}
$(document).ready(spinner_ready);
$(document).on('page:load', spinner_ready);
$(document).on('page:fetch', start_spinner);
$(document).on('page:receive', stop_spinner);
