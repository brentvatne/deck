class DeckIndexView extends Backbone.View
  class: 'deck-index-wrap'

  template: _.template($('#deck-index-template').html())

  render: ->
    @$el.html(@template(number_of_decks: @collection.length))

    _.each(@collection.models, (deck) =>
      iconView = new DeckApp.DeckIconView(model: deck)
      @deckListElement().append(iconView.render())
    )

  initialize: ->
    #@collection.on 'reset', @render, this

  deckListElement: ->
    @$el.find('.deck-list')

@DeckApp = window.DeckApp || {}
@DeckApp.DeckIndexView = DeckIndexView
