class DeckIconView extends Backbone.View
  tagName: 'li'

  class: 'deck-stack'

  template: JST['templates/deck/icon']

  initialize: ->
    @deck = @model
    @deck.on 'sync', @render, this

  render: ->
    @$el.html @template(@deck.toJSON())

@da = window.da
@da.views.DeckIconView = DeckIconView
