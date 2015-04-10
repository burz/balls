function submit_league () {
  $('#league_name_alert').hide();
  if($('#league_name').val() === "") {
    $('#league_name_alert').show();
    return false;
  }
  return true;
}
function leagues_ready () {
  $('.league_row').click(function (event_object) {
    var target_path = event_object.target.parentElement.getAttribute('league_path');
    Turbolinks.visit(target_path);
  });
  $('#league_name_alert').hide();
  $('#add_league_button').click(function () {
    Turbolinks.visit('/leagues/new');
  });
  $('#league_form').submit(submit_league);
}
$(document).ready(leagues_ready);
$(document).on('page:load', leagues_ready);
