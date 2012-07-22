class Slides extends Backbone.Collection

  url: ->
    "/api/decks/#{@deckID}/slides"

  model: da.models.Slide

  initialize: (options) ->
    @deckID = options.deckID

@da = window.da
@da.collections.Slides = Slides
