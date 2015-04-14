module ApplicationHelper
  require 'uri'

  def url_for(options = {})
    options = case options
    when String
      if params[:client] != 'web'
        uri = URI(options)
        uri.path = '/' + params[:client] + uri.path
        uri.to_s
      else
        options
      end
    when Hash
      options.reverse_merge client: params[:client]
    else
      options
    end
    super
  end

  def app_client?
    ['and', 'ios'].include? params[:client]
  end

  def format_ratio ratio
    if ratio >= 0
      ('<font color="green">+' + ratio.to_s + '</font>').html_safe
    else
      ('<font color="red">' + ratio.to_s + '</font>').html_safe
    end
  end

  def format_date date
    date.strftime '%B %e, %Y'
  end
end
