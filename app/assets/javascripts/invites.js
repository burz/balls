function create_new_player_invite () {
  $('.invite_alert').hide();
  if($('#league_selector').val() === '') {
    $('#league_alert').show();
  } else if($('#email_address').val() != '') {
    start_spinner();
    var emails = $('#email_address').val().split(',');
    var count = emails.length;
    var leagues_path = $('#invite_page').attr('leagues_path');
    for(var i = 0; i < emails.length; ++i) {
      var league_id = $('#league_selector').val();
      var league_path = leagues_path + '/' + league_id;
      var data = { invite: { email: emails[i].trim() } };
      $.post(league_path + '/invites', data, function () {
        if(--count === 0) {
          Turbolinks.visit(league_path);
        }
      });
    }
  } else {
    $('#email_alert').show();
  }
}
function send_invite () {
  $('.invite_alert').hide();
  if($('#email_address').val() != '') {
    start_spinner();
    var emails = $('#email_address').val().split(',');
    var count = emails.length;
    var league_path = $('#invite_page').attr('league_path');
    for(var i = 0; i < emails.length; ++i) {
      var data = { invite: { email: emails[i].trim() } };
      $.post(league_path + '/invites', data, function () {
        if(--count === 0) {
          Turbolinks.visit(league_path + '/admin');
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
  $('#send_invite_button').click(send_invite);
  $('#phone_contacts_button').click(function () {
    $('#email_invites_pane').hide();
    $('#email_button').removeClass('active');
    $('#phone_contacts_button').addClass('active');
    $('#contact_invites_pane').show();
  });
  $('#email_button').click(function () {
    $('#contact_invites_pane').hide();
    $('#phone_contacts_button').removeClass('active');
    $('#email_button').addClass('active');
    $('#email_invites_pane').show();
  });
}
$(document).ready(invites_ready);
$(document).on('page:load', invites_ready);
