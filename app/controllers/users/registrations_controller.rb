class Users::RegistrationsController < Devise::RegistrationsController
  require 'uri'

  def create
    session['user_return_to'] ||= '/'
    uri = URI(session['user_return_to'])
    old_query = uri.query || ''
    new_query = URI.decode_www_form(old_query) << ["new_user", "true"]
    uri.query = URI.encode_www_form(new_query)
    session['user_return_to'] = url_for uri.to_s
    super
  end
end
