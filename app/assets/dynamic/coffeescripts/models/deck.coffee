class Deck extends Backbone.Model

  urlRoot: '/api/decks'

@DeckApp = window.DeckApp || {}
@DeckApp.Deck = Deck
