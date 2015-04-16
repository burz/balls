function is_encountered(player, encountered_players) {
  for(var i = 0; i < encountered_players.length; ++i) {
    if(encountered_players[i] === player) {
      return true;
    }
  }
  return false;
}
function save_game () {
  $('.log_game_alert').hide();
  if($('#game_league_name').val() === '') {
    $('#game_league_name_alert').show();
  } else if($('#game_season_name').val() === '') {
    $('#game_season_name_alert').show();
  } else if($('#cup_differential').val() === '' ||
            $('#cup_differential').val() < 0) {
    $('#cup_differential_alert').show();
  } else if(parseInt($('#cup_differential').val()) >
            parseInt($('#game_season_name').find(':selected').attr('cups_per_team'))) {
    $('#differential_too_big_alert').show();
  } else {
    var selected_season = $('#game_season_name').find(':selected');
    var players_per_team = parseInt(selected_season.attr('players_per_team'));
    var winners = [];
    var losers = [];
    var encountered_players = [];
    for(var i = 0; i < players_per_team; ++i) {
      var winners_player = $('#winners #player' + i).val();
      if(winners_player === '') {
        $('#no_player_alert').show();
        return;
      } else if(is_encountered(winners_player, encountered_players)) {
        $('#duplicate_player_alert').show();
        return;
      }
      winners[winners.length] = winners_player;
      encountered_players[encountered_players.length] = winners_player;
      var losers_player = $('#losers #player' + i).val();
      if(losers_player === '') {
        $('#no_player_alert').show();
        return;
      } else if(is_encountered(losers_player, encountered_players)) {
        $('#duplicate_player_alert').show();
        return;
      }
      losers[losers.length] = losers_player;
      encountered_players[encountered_players.length] = losers_player;
    }
    var data = {
      game: {
        cup_differential: $('#cup_differential').val(),
        winners: winners,
        losers: losers
      }
    };
    var season_path = $('#new_game').attr('leagues_path') + '/' +
                      $('#game_league_name').val() +
                      '/seasons/' + $('#game_season_name').val();
    $.post(
      season_path + '/games/',
      data,
      function (data) {
        Turbolinks.visit(season_path + '/games/' + data.game_id);
      }
    );
  }
}
var seasons = [];
var players = [];
function league_change () {
  $('.log_game_alert').hide();
  $('#winners').empty();
  $('#losers').empty();
  if($('#game_league_name').val() != "") {
    $.get(
      '/leagues/' + $('#game_league_name').val() + '/seasons.json',
      function (data) {
        seasons = data;
        $('#game_season_name').empty();
        $('#game_season_name').append('<option value="">Select a season</option>');
        if(seasons.length > 0) {
          seasons.forEach(function (season) {
            var ops = '<option id="season' + season.id +
                      '" cups_per_team="' + season.cups_per_team +
                      '" players_per_team="' + season.players_per_team + '">';
            var option = $('<option id="season' + season.id + '">').val(season.id)
            option.append(season.name);
            $('#game_season_name').append(option);
            $('#season' + season.id).attr({
              cups_per_team: season.cups_per_team,
              players_per_team: season.players_per_team
            });
          });
          $('#game_season_name').prop('disabled', false);
        } else {
          $('#no_seasons_alert').show();
          return;
        }
      }
    );
    $.get(
      '/leagues/' + $('#game_league_name').val() + '/players.json',
      function (data) {
        players = data;
      }
    );
  } else {
    $('#game_season_name').prop('disabled', true);
  }
}
function create_player(t, i) {
  if(t === 0) {
    var player = $('<div class="team' + t + ' panel panel-success">');
  } else {
    var player = $('<div class="team' + t + ' panel panel-danger">');
  }
  player.append('<div class="panel-heading">Player ' + (i + 1) + '</div>');
  var body = $('<div class="panel-body">')
  body.append('<label for="player' + i + '">');
  var select = $('<select id="player' + i + '" class="player form-control">');
  select.append('<option value="">Select a player</option>');
  body.append(select);
  player.append(body);
  return player;
}
function season_change () {
  $('#winners').empty();
  $('#losers').empty();
  if($('#game_season_name').val() != "") {
    $('#winners').append('<h3>Winners</h3>');
    $('#losers').append('<h3>Losers</h3>');
    var selected_season = $('#game_season_name').find(':selected');
    var players_per_team = parseInt(selected_season.attr('players_per_team'));
    for(var i = 0; i < players_per_team; ++i) {
      $('#winners').append(create_player(0, i));
      $('#losers').append(create_player(1, i));
    }
    players.forEach(function (player) {
      var option = $('<option>').val(player.id).append(player.name);
      $('.player').append(option);
    });
  }
}
function games_ready () {
  $('.game_row').click(function (event_object) {
    var target_path = event_object.target.parentElement.getAttribute('game_path');
    Turbolinks.visit(target_path);
  });
  $('.log_game_alert').hide();
  $('#save_game_button').click(save_game);
  seasons = [];
  players = [];
  $('#game_league_name').change(league_change);
  $('#game_season_name').change(season_change);
  $('.game_date').each(function (i, date_string) {
    date_string.textContent = moment(date_string.textContent).fromNow();
  });
  var played_date = $('#played_date');
  played_date.text(moment(played_date.text()).format('h:mm:ssa On MMMM Do YYYY'));
}
$(document).ready(games_ready);
$(document).on('page:load', games_ready);
