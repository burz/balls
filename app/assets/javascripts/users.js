var selected_rating = 0;
function handle_buttons (children) {
  if(children === -1) {
    $('#last_rating_button').prop('disabled', true);
    $('#next_rating_button').prop('disabled', true);
  } else {
    if(selected_rating === 0) {
      $('#last_rating_button').prop('disabled', true);
    } else {
      $('#last_rating_button').prop('disabled', false);
    }
    if(selected_rating === children) {
      $('#next_rating_button').prop('disabled', true);
    } else {
      $('#next_rating_button').prop('disabled', false);
    }
  }
}
function users_ready () {
  $('.league_rating').hide();
  $('#rating0').show();
  selected_rating = 0;
  handle_buttons($('#leagues_panel').children().length - 1);
  $('#next_rating_button').click(function () {
    var children = $('#leagues_panel').children().length - 1;
    if(selected_rating < children) {
      $('.league_rating').hide();
      $('#rating' + (++selected_rating)).show();
    }
    handle_buttons(children);
  });
  $('#last_rating_button').click(function () {
    var children = $('#leagues_panel').children().length - 1;
    if(selected_rating > 0) {
      $('.league_rating').hide();
      $('#rating' + (--selected_rating)).show();
    }
    handle_buttons(children);
  });
  $('#new_user').submit(function () {
    if($('#sign_up_name').val() != '') {
      goog_report_conversion(window.location.href);
      return true;
    } else {
      $('#sign_up_name_alert').show();
      return false;
    }
  });
  $('#season_ratings_button').click(function () {
    $('#league_ratings_button').removeClass('active');
    $('#league_ratings_graph').hide();
    $('#season_ratings_graph').show();
    $('#season_ratings_button').addClass('active');
  });
  $('#league_ratings_button').click(function () {
    $('#season_ratings_button').removeClass('active');
    $('#season_ratings_graph').hide();
    $('#league_ratings_graph').show();
    $('#league_ratings_button').addClass('active');
  });
  $('#error_explanation').addClass('alert alert-danger');
  $('#edit_user_form').submit(function () {
    $('#edit_user_name_alert').hide();
    var name = $('#edit_user_name');
    if(name.val() != '') {
      name.val(name.val().trim());
      return true;
    } else {
      $('#edit_user_name_alert').show();
      return false;
    }
  });
}
$(document).ready(users_ready);
$(document).on('page:load', users_ready);
