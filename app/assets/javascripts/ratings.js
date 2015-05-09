function ratings_ready() {
  var ratings_container = $('#ratings_container');
  var rating_rows = $('.rating_row');
  rating_rows.click(function (event_object) {
    var user_id = event_object.target.parentElement.getAttribute('user_id');
    var url = ratings_container.attr('users') + '/' + user_id;
    Turbolinks.visit(url);
  });
  rating_rows.each(function (i, row) {
    if(row.getAttribute('user_id') === ratings_container.attr('me')) {
      row.className += ' current_user_row';
    }
  });
}
$(document).ready(ratings_ready);
$(document).on('page:load', ratings_ready);
