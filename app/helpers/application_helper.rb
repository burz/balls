module ApplicationHelper
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

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == '1'
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
end
