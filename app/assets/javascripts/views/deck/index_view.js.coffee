class DeckIndexView extends Backbone.View
  class: 'deck-index-wrap'

  template: JST['templates/deck/index']

  initialize: ->
    da.ui.showLoading()

    @decks = new da.collections.Decks
    @decks.on 'reset', @render, this
    @decks.fetch()

  render: ->
    da.ui.hideLoading()

    @$el.html @template()

    if @decks.models.length == 0
      @deckListView = new da.views.EmptyDeckListView
    else
      @deckListView = new da.views.DeckListView

    @$el.append(@deckListView.el)

@da = window.da
@da.views.DeckIndexView = DeckIndexView
