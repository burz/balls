//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require slideout
//= require spin
//= require jquery.tipsy
//= require d3
//= require jquery-ui
//= require_tree .

function application_ready () {
  $('.rating_row').click(function (event_object) {
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
