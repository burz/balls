//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require slideout
//= require spin
//= require jquery.tipsy
//= require d3
//= require jquery-ui
//= require moment
//= require_tree .

function application_ready () {
  $('.global_alert').each(function (i, alert_element) {
    if(alert_element.innerText === '') {
      alert_element.hidden = true;
    }
  });
}
$(document).ready(application_ready);
$(document).on('page:load', application_ready);
