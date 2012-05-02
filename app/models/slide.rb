require 'redcarpet'

module DeckApp
  class Slide
    include DataMapper::Resource

    belongs_to :deck

    property :id,      Serial
    property :number,  Integer
    property :content, String

    def content_as_html
      render(content)
    end

    def render(markdown_text)
      @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                            :autolink => true,
                                            :space_after_headers => true,
                                            :fenced_code_blocks => true,)
      @markdown.render(markdown_text)
    end
  end
end
