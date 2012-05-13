class Deck extends Backbone.Model

  urlRoot: '/decks'

@DeckApp = window.DeckApp || {}
@DeckApp.Deck = Deck
