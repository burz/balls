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
end
