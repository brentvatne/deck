class Decks extends Backbone.Collection

  url: '/api/decks'

  model: da.models.Deck


@da = window.da
@da.collections.Decks = Decks
