module ApplicationHelper

  STYLES = {
    h1: 'margin-bottom: 20px; margin-top: 10px; font-size: 32px;',
    h2: 'margin-bottom: 10px; margin-top: 15px; font-size: 18px;',
    h3: 'margin-bottom: 10px; margin-top: 15px; font-size: 14px;',
    a: 'text-decoration: none; color: #32aeee;',
    p: 'margin-bottom: 10px; line-height: 20px;'    
  }

  def email_tag(type, options = {}, &content)
    options[:style] ||= STYLES[type]
    options[:target] = '_blank' if type == :a
    content_tag type, options, &content
  end

end
