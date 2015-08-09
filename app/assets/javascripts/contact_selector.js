function contact_click (event_object) {
  var selected = event_object.target;
  if(selected.hasAttribute('clicked')) {
    selected.setAttribute('class', 'phone_contact list-group-item');
    selected.removeAttribute('clicked');
  } else {
    selected.setAttribute('class', 'phone_contact list-group-item list-group-item-info');
    selected.setAttribute('clicked', true);
  }
}
function add_contact (name, number) {
  var li = $('<li class="phone_contact list-group-item" phone_number="' +
             number + '">' + name + '</li>')
    .click(contact_click);
  $('#contacts_list').append(li);
}
function no_selected_contacts () {
  var contacts = $('.phone_contact');
  for(var i = 0; i < contacts.length; ++i)
    if(contacts[i].hasAttribute('clicked'))
      return false;
  return true;
}
function get_selected_contacts () {
  var results = [];
  $('.phone_contact').each(function (i, contact) {
    if(contact.hasAttribute('clicked'))
        results[results.length] = contact;
  });
  return results;
}
