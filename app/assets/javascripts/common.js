function common_ready () {
  $('#sign_up_button').click(function () {
    $('#log_in_button').removeClass('active');
    $('#sign_up_button').addClass('active');
    $('#log_in_pane').hide();
    $('#sign_up_pane').show();
    $('#sign_up_name').focus();
  });
  $('#log_in_button').click(function () {
    $('#sign_up_button').removeClass('active');
    $('#log_in_button').addClass('active');
    $('#sign_up_pane').hide();
    $('#log_in_pane').show();
    $('#log_in_email').focus();
  });
  $('tbody tr').hover(function () {
    $(this).children('td').each(function () {
        $(this).css('background-color', '#FFFCF8');
    });
  }, function () {
    $(this).children('td').each(function () {
        $(this).css('background-color', '#EFEFEF');
    });
  });
}
$(document).ready(common_ready);
$(document).on('page:load', common_ready);
