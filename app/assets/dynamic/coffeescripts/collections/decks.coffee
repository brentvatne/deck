class Decks extends Backbone.Collection

  url: '/api/decks'

  model: D.Deck

@D = window.D || {}
@D.Decks = new Decks
