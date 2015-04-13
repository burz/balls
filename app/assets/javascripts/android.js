function send_contact_invite_android(number) {
  $.get($('#invite_contacts').attr('league_generate_invite_path'), function (data) {
    BallsAppAndroid.sendInvite(number, data.league_name, data.invite_path);
  });
}
function android_ready () {
  $('#send_contact_invites').click(function () {
    
  });
}
