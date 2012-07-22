class Slides extends Backbone.Collection

  url: ->
    "/api/decks/#{D.currentDeckID}/slides"

  model: D.Slide

@D = window.D || {}
@D.Slides = new Slides
