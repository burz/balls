function shuffle_array(array) {
  var current_index = array.length;
  while(0 !== current_index) {
    var random_index = Math.floor(Math.random() * current_index);
    --current_index;
    var temporary_value = array[current_index];
    array[current_index] = array[random_index];
    array[random_index] = temporary_value;
  }
  return array;
}
function create_random_bracket_iteration(players, team_size) {
  var two_team_size = team_size * 2;
  var half_length = players.length / 2;
  if(players.length <= two_team_size) {
    return {
      game: {
        home: players.slice(0, half_length),
        away: players.slice(half_length)
      }
    };
  } else {
    var left = create_random_bracket_iteration(players.slice(0, half_length), team_size);
    var right = create_random_bracket_iteration(players.slice(half_length), team_size);
    return {
      round: {
        left: left,
        right: right
      }
    };
  }
}
function create_random_bracket(players, team_size) {
  var two_team_size = team_size * 2;
  var number_of_participants = Math.floor(players.length / two_team_size) * two_team_size;
  var shuffled_players = shuffle_array(players.slice(0, number_of_participants));
  return {
    matches: create_random_bracket_iteration(shuffled_players, team_size),
    unmatched: players.slice(number_of_participants)
  };
}
