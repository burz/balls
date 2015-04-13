function create_new_player_invite () {
  $('.invite_alert').hide();
  if($('#league_selector').val() === '') {
    $('#league_alert').show();
  } else if($('#email_address').val() != '') {
    var emails = $('#email_address').val().split(',');
    var count = emails.length;
    start_spinner();
    for(var i = 0; i < emails.length; ++i) {
      var league_id = $('#league_selector').val();
      var data = { invite: { email: emails[i].trim() } };
      $.post('leagues/' + league_id + '/invites', data, function () {
        if(--count === 0) {
          Turbolinks.visit($('#invite_page').attr('leagues_path') + '/' + league_id);
        }
      });
    }
  } else {
    $('#email_alert').show();
  }
}
function invites_ready () {
  $('.invite_alert').hide();
  $('#create_new_player_invite').click(create_new_player_invite);
}
$(document).ready(invites_ready);
$(document).on('page:load', invites_ready);
