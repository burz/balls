function seasons_ready () {
  $('.season_row').click(function (event_object) {
    var target_path = event_object.target.parentElement.getAttribute('season_path');
    Turbolinks.visit(target_path);
  });
  $('.new_season_alert').hide();
  $('#extra_rules_body').hide();
  $('#extra_rules_heading').click(function () {
    $('#extra_rules_body').toggle();
  });
  $('#rules_panel').hide();
  $('#rules_button').click(function () {
    $('#rules_panel').toggle();
  });
}
$(document).ready(seasons_ready);
$(document).on('page:load', seasons_ready);
