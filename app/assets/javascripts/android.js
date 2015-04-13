function send_invite_android(number) {
  $.get($('#invite_contacts').attr('league_generate_invite_path'), function (data) {
    BallsAppAndroid.sendInvite(number, data.league_name, data.invite_path);
  });
}
function load_contacts_android () {
  BallsAppAndroid.loadContacts();
}
function android_ready () {
  load_contacts_android();
  $('#send_contact_invites').click(function () {
    $('#contact_list').children().each(function (i, contact) {
      send_invite_android(contact.getAttribute('phone_number'));
    });
  });
}
