class DeckListView extends Backbone.View
  tagName: 'ul'

  className: 'deck-list'

  initialize: ->
    da.ui.showLoading()

    @decks = new da.collections.Decks
    @decks.on 'reset', @render, this
    @decks.fetch()

  render: ->
    da.ui.hideLoading()

    _.each @decks.models, (deck) =>
      iconView = new da.views.DeckIconView(model: deck)
      @$el.append iconView.render()

@da = window.da
@da.views.DeckListView = DeckListView
