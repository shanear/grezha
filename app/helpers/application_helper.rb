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
      # Offline cahcing is annoying while developing, enable if testing needed
    if Rails.env.development?
      ""
    else
      "manifest = '/application.manifest'".html_safe
    end
  end
end
