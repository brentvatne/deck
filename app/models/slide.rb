module DeckApp
  class Slide
    include DataMapper::Resource

    belongs_to :deck

    property :id,      Serial
    property :number,  Integer
    property :content, String
  end
end
