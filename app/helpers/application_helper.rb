module ApplicationHelper

  def markdown_to_html(markdown)
	renderer = Redcarpet::Render::HTML.new
	extenstions = {fenced_code_blocks: true}
	redcarpet = Redcarpet::Markdown.new(renderer, extenstions)
	(redcarpet.render markdown).html_safe
  end

   def hide_email(email)
     email.split('@').first + '@xxxxx.com'
      end
end
