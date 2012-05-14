require_relative "../../config/data_mapper"

module DeckApp
  class User
    include DataMapper::Resource

    has 1, :token_pair
    has n, :decks

    property :id,    Serial
    property :email, String, :unique => true

    def self.find_or_create_from_omniauth(params)
      first_or_create({:email => params['info']['email']}, {
        :token_pair => TokenPair.create(params['credentials'])
      })
    end

    def self.token_pair_for(email)
      first(:email => email).token_pair
    end

    def create_deck(name)
      deck = Deck.create(name)
      decks << deck
      save

      deck
    end
  end
end
