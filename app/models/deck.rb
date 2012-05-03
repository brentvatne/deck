module DeckApp
  class Deck
    include DataMapper::Resource

    belongs_to :user
    has n,     :slides

    property :id,   Serial
    property :name, String, :unique => true

    def create_slide(content)
      slide = Slide.create(:content => content, :number => next_number)
      slides << slide
      save
    end

    def next_number
      (slides.max(:number) || 0) + 1
    end

    def delete_slide
      # move the numbers accordingly
    end
  end
end
