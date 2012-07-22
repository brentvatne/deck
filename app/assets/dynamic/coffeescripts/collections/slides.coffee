class Slides extends Backbone.Collection

  url: ->
    "/api/decks/#{da.app.currentDeck.get('id')}/slides"

  model: da.models.Slide

@da = window.da
@da.collections.Slides = Slides
