function invites_ready () {
  $('#email_alert').hide();
}
$(document).ready(invites_ready);
$(document).on('page:load', invites_ready);
