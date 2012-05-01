class Thing extends Backbone.Model
  isAThing: -> @get("thinginess")

@Deck = window.Deck || {}
@Deck.Thing = Thing
