class DeckIconView extends Backbone.View
  tagName: 'li'

  class: 'deck-stack'

  template: _.template($('#deck-icon-template').html())

  initialize: ->
    @model.on 'sync', @render, this

  render: ->
    @$el.html(@template(@model.toJSON()))

@da = window.da
@da.views.DeckIconView = DeckIconView
