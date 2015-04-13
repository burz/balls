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
  $('#league_form').submit(submit_league);
  $('.admin_checkbox').click(function (event_object) {
    var user_id = event_object.target.getAttribute('user_id');
    var path = $('#league_members').attr('league_admin_path') + '/' + user_id + '/toggle';
    $.get(path);
  });
}
$(document).ready(leagues_ready);
$(document).on('page:load', leagues_ready);
