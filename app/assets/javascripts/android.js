function send_contact_invites_android () {
  start_spinner();
  var contacts = $('#contact_list').children();
  var count = contacts.length;
  var send_invite_android = function (number) {
    $.get($('#invite_contacts').attr('league_generate_invite_path'), function (data) {
      BallsAppAndroid.sendInvite(number, data.league_name, data.invite_path);
      if(--count === 0) {
        Turbolinks.visit($('#invite_contacts').attr('league_path'));
      }
    });
  };
  $('#contact_list').children().each(function (i, contact) {
    send_invite_android(contact.getAttribute('phone_number'));
  });
}
function load_contacts_android () {
  BallsAppAndroid.loadContacts();
}
function android_ready () {
  load_contacts_android();
  $('#send_contact_invites').click(send_contact_invites_android);
}
