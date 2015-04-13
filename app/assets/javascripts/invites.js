function create_new_player_invite () {
  $('.invite_alert').hide();
  if($('#league_selector').val() === '') {
    $('#league_alert').show();
  } else if($('#email_address').val() != '') {
    start_spinner();
    var emails = $('#email_address').val().split(',');
    var count = emails.length;
    var league_path = $('#invite_page').attr('league_path');
    for(var i = 0; i < emails.length; ++i) {
      var league_id = $('#league_selector').val();
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
function add_contact (name, number) {
  $('#contact_list').append(
    '<li phone_number="' + number + '" class="contact list-group-item">' + name + '</li>'
  );
}
function invites_ready () {
  $('.invite_alert').hide();
  $('#create_new_player_invite').click(create_new_player_invite);
  $('#send_invite_button').click(send_invite);
}
$(document).ready(invites_ready);
$(document).on('page:load', invites_ready);
