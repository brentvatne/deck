class DeckNewView extends Backbone.View
  tagName: 'li'

  class: 'deck-stack'

  template: _.template($('#deck-icon-template').html())

  render: ->
    @$el.html(@template(@model.toJSON()))

@DeckApp = window.DeckApp || {}
@DeckApp.DeckIconView = DeckIconView
