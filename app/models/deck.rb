module StarterApp
  class Deck
    include DataMapper::Resource

    belongs_to :user

    property :id,   Serial
    property :name, String, :unique => true
  end
end
