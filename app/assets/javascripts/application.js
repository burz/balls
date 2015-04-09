//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require slideout
//= require spin
//= require jsapi
//= require chartkick
//= require jquery.tipsy
//= require d3
//= require_tree .

function application_ready () {
  $('.user_row').click(function (event_object) {
    var target_path = event_object.target.parentElement.getAttribute('user_path');
    Turbolinks.visit(target_path);
  });
  $('.global_alert').each(function (i, alert_element) {
    if(alert_element.innerText === '') {
      alert_element.hidden = true;
    }
  });
}
$(document).ready(application_ready);
$(document).on('page:load', application_ready);
