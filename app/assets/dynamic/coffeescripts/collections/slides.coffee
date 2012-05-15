class Slides extends Backbone.Collection

  url: ->
    "/api/decks/#{@deckID}/slides"

  model: DeckApp.Slide

  initialize: (options) ->
    @deckID = options.deckID

@DeckApp = window.DeckApp || {}
@DeckApp.Slides = Slides
