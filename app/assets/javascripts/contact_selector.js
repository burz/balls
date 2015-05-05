(function ($) {
  $.widget('custom.combobox', {
    _create: function () {
      this.wrapper = $('<span>').addClass('custom-combobox').insertAfter(this.element);
      this.element.hide();
      this._createAutocomplete();
      this._createShowAllButton();
    },
    _createAutocomplete: function () {
      var selected = this.element.children(':selected');
      var value = selected.val() ? selected.text() : '';
      this.input = $('<input>').appendTo(this.wrapper).val(value).attr('title', '')
        .addClass('custom-combobox-input ui-widget ui-widget-content ui-corner-left')
        .autocomplete({
          delay: 0,
          minLength: 0,
          source: $.proxy(this, '_source')
        }).tooltip({
          tooltipClass: 'ui-state-highlight'
        });
      this._on(this.input, {
        autocompleteselect: function (event, ui) {
          ui.item.option.selected = true;
          this._trigger('select', event, {
            item: ui.item.option
          });
          var selected_contact = ui.item.option;
          if(selected_contact.value != '') {
            add_selected_contact(selected_contact.text, selected_contact.value);
          }
          setTimeout(function () {
            $('.custom-combobox input').val('');
          }, 500);
        },
        autocompletechange: '_removeIfInvalid'
      });
    },
    _createShowAllButton: function () {
      var input = this.input;
      var wasOpen = false;
      $('<a>').attr('tabIndex', -1)
        .appendTo(this.wrapper).button({
          icons: {
            primary: 'ui-icon-triangle-1-s'
          },
          text: false
        }).removeClass('ui-corner-all').addClass('custom-combobox-toggle ui-corner-right')
        .mousedown(function () {
          wasOpen = input.autocomplete('widget').is(':visible');
        }).click(function () {
          input.focus();
          if (wasOpen) {
            return;
          }
          input.autocomplete('search', '');
        });
    },
    _source: function (request, response) {
      var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), 'i');
      response(this.element.children('option').map(function () {
        var text = $(this).text();
        if(this.value && (!request.term || matcher.test(text)))
          return {
            label: text,
            value: text,
            option: this
          };
      }));
    },
    _removeIfInvalid: function (event, ui) {
      if (ui.item) {
        return;
      }
      var value = this.input.val(),
        valueLowerCase = value.toLowerCase(),
        valid = false;
      this.element.children('option').each(function () {
        if ($(this).text().toLowerCase() === valueLowerCase) {
          this.selected = valid = true;
          return false;
        }
      });
      if (valid) {
        return;
      }
      this.input.val('').attr('title', value + ' didn\'t match any item').tooltip('open');
      this.element.val('');
      this._delay(function () {
        this.input.tooltip('close').attr('title', '');
      }, 2500);
      this.input.autocomplete('instance').term = '';
    },
    _destroy: function () {
      this.wrapper.remove();
      this.element.show();
    }
  });
})(jQuery);
function add_contact (name, number) {
  $('#contact_list').append('<option value="' + number + '">' + name + '</li>');
}
function add_selected_contact (name, number) {
  var remove_button = $('<span class="glyphicon glyphicon-remove" aria-hidden="true">');
  $('<li phone_number="' + number + '" class="contact list-group-item">' + name + '</li>')
    .append(remove_button).appendTo($('#selected_contact_list'));
  remove_button.click(function () {
    this.parentElement.remove();
  });
}
function contact_selector_ready () {
  $('#contact_list').combobox();
}
