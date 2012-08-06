class DeckIconView extends Backbone.View
  tagName: 'li'

  class: 'deck-stack'

  template: _.template($('#deck-icon-template').html())

  initialize: ->
    @deck = @model
    @deck.on 'sync', @render, this

  render: ->
    @$el.html @template(@deck.toJSON())

@da = window.da
@da.views.DeckIconView = DeckIconView
