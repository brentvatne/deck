class Decks extends Backbone.Collection
  url: '/api/decks'

  model: DeckApp.Deck

@DeckApp = window.DeckApp || {}
@DeckApp.Decks = new Decks
