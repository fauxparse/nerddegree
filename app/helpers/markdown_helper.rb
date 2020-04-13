module MarkdownHelper
  class HTMLWithPants < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end

  def markdown(plain_text)
    markdown_renderer.render(plain_text).html_safe
  end

  private

  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Markdown.new(
      HTMLWithPants.new(
        filter_html: true,
        no_images: true,
        safe_links_only: true,
        link_attributes: { target: '_blank' }
      )
    )
  end
end
