class DeckIndexView extends Backbone.View
  class: 'deck-index-wrap'

  template: _.template($('#deck-index-view-template').html())

@DeckApp = window.DeckApp || {}
@DeckApp.DeckIndexView = DeckIndexView
