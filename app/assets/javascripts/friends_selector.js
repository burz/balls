function friend_click (event_object) {
  var selected = event_object.target;
  if(selected.hasAttribute('clicked')) {
    selected.setAttribute('class', 'friend list-group-item');
    selected.removeAttribute('clicked');
  } else {
    selected.setAttribute('class', 'friend list-group-item list-group-item-info');
    selected.setAttribute('clicked', true);
  }
}
function get_selected_friends () {
  var results = [];
  $('.friend').each(function (i, contact) {
    if(contact.hasAttribute('clicked'))
        results[results.length] = contact;
  });
  return results;
}
function send_friend_invite () {
  $('.invite_alert').hide();
  var friends = get_selected_friends();
  if(friends.length === 0)
    $('#friend_alert').show();
  else {
    start_spinner();
    var count = friends.length;
    var league_path = $('#invite_page').attr('league_path');
    for(var i = 0; i < friends.length; ++i) {
      var data = {
        invite: {
          id: friends[i].getAttribute('friend_id')
        }
      };
      $.post(league_path + '/invite/friend', data, function () {
        if(--count === 0) {
          Turbolinks.visit(league_path + '/admin');
        }
      });
    }
  }
}
function send_general_friend_invite () {
  $('.invite_alert').hide();
  var friends = get_selected_friends();
  if($('#friend_league_selector').val() === '')
    $('#friend_league_alert').show();
  else if(friends.length === 0)
    $('#friend_alert').show();
  else {
    start_spinner();
    var count = friends.length;
    var leagues_path = $('#invite_page').attr('leagues_path');
    var league_id = $('#friend_league_selector').val();
    var league_path = leagues_path + '/' + league_id;
    for(var i = 0; i < friends.length; ++i) {
      var data = {
        invite: {
          id: friends[i].getAttribute('friend_id')
        }
      };
      $.post(league_path + '/invite/friend', data, function () {
        if(--count === 0) {
          Turbolinks.visit(league_path + '/admin');
        }
      });
    }
  }
}
function friends_ready () {
  $('.friend').click(friend_click);
  $('#create_friend_invite').click(send_friend_invite);
  $('#create_general_friend_invite').click(send_general_friend_invite);
}
$(document).ready(friends_ready);
$(document).on('page:load', friends_ready);
