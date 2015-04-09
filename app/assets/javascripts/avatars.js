function avatar_input (input) {
  if(input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (event_object) {
      $('#new_avatar').attr('src', event_object.target.result);
    };
    reader.readAsDataURL(input.files[0]);
  }
}
function send_avatar (input) {
  if(input.files && input.files[0]) {
    $('#user_avatar_form').submit();
  } else {
    $('#avatar_file_alert').show();
  }
}
function avatar_ready () {
  $('#user_avatar_display').click(function () {
    $('#user_avatar_upload_modal').modal('show');
  });
  $('#new_user_avatar').change(function () {
    $('#avatar_file_alert').hide();
    avatar_input(this);
  });
  $('#save_avatar_button').click(function () {
    $('#avatar_file_alert').hide();
    start_spinner();
    send_avatar($('#new_user_avatar')[0]);
  });
}
$(document).ready(avatar_ready);
$(document).on('page:load', avatar_ready);
