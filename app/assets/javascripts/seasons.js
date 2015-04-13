function submit_season () {
  $('.new_season_alert').hide();
  if($('#season_name').val() === "") {
    $('#season_name_alert').show();
    return false;
  } else if($('#season_end_date').val() === "") {
    $('#season_date_alert').show();
    return false;
  } else if($('#season_players_per_team').val() === "" ||
            $('#season_players_per_team').val() <= 0) {
    $('#season_players_alert').show();
    return false;
  } else if($('#season_cups_per_team').val() === "" ||
            $('#season_cups_per_team').val() <= 0) {
    $('#season_cups_alert').show();
    return false;
  } else if($('#season_number_of_balls').val() === "" ||
            $('#season_number_of_balls').val() <= 0) {
    $('#season_balls_alert').show();
    return false;
  }
  return true;
}
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
  $('#season_form').submit(submit_season);
  $('#add_season_button').click(function () {
    Turbolinks.visit($('#add_season_button').attr('season_path'));
  });
}
$(document).ready(seasons_ready);
$(document).on('page:load', seasons_ready);
