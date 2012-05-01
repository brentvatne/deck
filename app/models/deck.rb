module DeckApp
  class Deck
    include DataMapper::Resource

    belongs_to :user
    has n,     :slides

    property :id,   Serial
    property :name, String, :unique => true

    def create_slide(content)
      slide = Slide.create(:content => content, :number => 1)
      slides << slide
      save
    end
  end
end
