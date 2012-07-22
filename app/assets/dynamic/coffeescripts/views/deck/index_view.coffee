class DeckIndexView extends Backbone.View
  class: 'deck-index-wrap'

  template: _.template($('#deck-index-template').html())

  initialize: ->
    da.ui.showLoading()
    @collection.on 'reset', @render, this

  render: ->
    da.ui.hideLoading()

    @$el.html(@template(numberOfDecks: @collection.length))

    _.each(@collection.models, (deck) =>
      iconView = new da.views.DeckIconView(model: deck)
      @deckListContainer().append(iconView.render())
    )

  # Private: Refers to the element rendered out by the deck-index-template
  # which contains the deck list items.
  deckListContainer: ->
    @$el.find('.deck-list')

@da = window.da
@da.views.DeckIndexView = DeckIndexView
