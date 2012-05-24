class DeckIndexView extends Backbone.View
  class: 'deck-index-wrap'

  template: _.template($('#deck-index-template').html())

  initialize: ->
    DeckApp.Util.showLoading()
    @collection.on 'reset', @render, this

  render: ->
    DeckApp.Util.hideLoading()

    @$el.html(@template(number_of_decks: @collection.length))

    _.each(@collection.models, (deck) =>
      iconView = new DeckApp.DeckIconView(model: deck)
      @deckListContainer().append(iconView.render())
    )

  # Private: Refers to the element rendered out by the deck-index-template
  # which contains the deck list items.
  deckListContainer: ->
    @$el.find('.deck-list')

@DeckApp = window.DeckApp || {}
@DeckApp.DeckIndexView = DeckIndexView
