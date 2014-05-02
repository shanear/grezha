module ApplicationHelper
  # Breaks text into html paragraphs and line breaks
  def format_long_text(text)
    output = ""

    text.split(/\n\s*\n/).each do |paragraph|
      output << content_tag(:p, paragraph)
    end

    output.gsub(/\n/, "<br/>").html_safe
  end

  def manifest_tag
    # Implement cache manifest in the demo, hold on releasing to production
    if Rails.env.demo?
      "manifest = '/application.manifest'".html_safe
    else
      ""
    end
  end
end
