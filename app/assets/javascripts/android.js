function send_contact_invites_android () {
  start_spinner();
  var contacts = get_selected_contacts();
  var count = contacts.length;
  var send_invite_android = function (number) {
    $.get($('#invite_contacts').attr('league_generate_invite_path'), function (data) {
      BallsAppAndroid.sendInvite(number, data.league_name, data.invite_path);
      if(--count === 0) {
        Turbolinks.visit($('#invite_contacts').attr('league_path'));
      }
    });
  };
  contacts.each(function (i, contact) {
    send_invite_android(contact.getAttribute('phone_number'));
  });
}
function send_general_contact_invites_android () {
  start_spinner();
  var contacts = $('#selected_contact_list').children();
  var count = contacts.length;
  var leagues_path = $('#invite_contacts').attr('leagues_path');
  var league_id = $('#contact_league_selector').val();
  var league_path = leagues_path + '/' + league_id;
  var league_generate_invite_path = league_path + '/invite/generate';
  var send_invite_android = function (number) {
    $.get(league_generate_invite_path, function (data) {
      BallsAppAndroid.sendInvite(number, data.league_name, data.invite_path);
      if(--count === 0) {
        Turbolinks.visit(league_path);
      }
    });
  };
  contacts.each(function (i, contact) {
    send_invite_android(contact.getAttribute('phone_number'));
  });
}
function load_contacts_android () {
  BallsAppAndroid.loadContacts();
}
function android_ready () {
  load_contacts_android();
  contact_selector_ready();
  $('#send_contact_invites').click(send_contact_invites_android);
  $('#send_general_contact_invites').click(function () {
    $('#contact_league_alert').hide();
    if(no_selected_contacts()) {
      $('#contact_league_alert').show();
    } else {
      send_general_contact_invites_android();
    }
  });
}
