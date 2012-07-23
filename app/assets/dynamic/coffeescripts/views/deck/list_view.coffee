class DeckListView extends Backbone.View
  class: 'deck-list'

  template: _.template($('#deck-index-template').html())

  initialize: ->
    da.ui.showLoading()

    @decks = new da.collections.Decks
    @decks.on 'reset', @render, this
    @decks.fetch()

  render: ->
    da.ui.hideLoading()

    @$el.html(@template(numberOfDecks: @decks.length))

    _.each(@decks.models, (deck) =>
      iconView = new da.views.DeckIconView(model: deck)
      @deckListContainer().append(iconView.render())
    )

  # Private: Refers to the element rendered out by the deck-index-template
  # which contains the deck list items.
  deckListContainer: ->
    @$el.find('.deck-list')

@da = window.da
@da.views.DeckListView = DeckListView
