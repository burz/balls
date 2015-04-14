function send_request_ios (action_type, action_parameters) {
  if(action_parameters === undefined) {
    action_parameters = {};
  }
  var json_string = JSON.stringify(action_parameters);
  var escaped_json_string = escape(json_string);
  var url = 'ballsapp://' + action_type + '#' + escaped_json_string;
  document.location.href = url;
}
function load_contacts_ios () {
  send_request_ios('GetContacts');
}
function send_invite_ios (number, token_path, callback) {
  $.get(token_path, function (data) {
    send_request_ios('SendInvite', {
      number: number,
      league_name: data.league_name,
      invite_path: data.invite_path
    });
    callback();
  });
}
function send_contact_invites_ios () {
  start_spinner();
  var contacts = $('#selected_contact_list').children();
  var count = contacts.length;
  var token_path = $('#invite_contacts').attr('league_generate_invite_path');
  var league_path = $('#invite_contacts').attr('league_path');
  contacts.each(function (i, contact) {
    var phone_number = contact.getAttribute('phone_number');
    send_invite_ios(phone_number, token_path, function () {
      if(--count === 0) {
        Turbolinks.visit(league_path);
      }
    });
  });
}
function send_general_contact_invites_ios () {
  start_spinner();
  var contacts = $('#selected_contact_list').children();
  var count = contacts.length;
  var leagues_path = $('#invite_contacts').attr('leagues_path');
  var league_id = $('#contact_league_selector').val();
  var league_path = leagues_path + '/' + league_id;
  var token_path = league_path + '/invite/generate';
  contacts.each(function (i, contact) {
    var phone_number = contact.getAttribute('phone_number');
    send_invite_ios(phone_number, token_path, function () {
      if(--count === 0) {
        Turbolinks.visit(league_path);
      }
    });
  });
}
function ios_ready () {
  load_contacts_ios();
  contact_selector_ready();
  $('#send_contact_invites').click(send_contact_invites_ios);
  $('#send_general_contact_invites').click(function () {
    $('#contact_league_alert').hide();
    if($('#contact_league_selector').val() === '') {
      $('#contact_league_alert').show();
    } else {
      send_general_contact_invites_ios();
    }
  });
}
