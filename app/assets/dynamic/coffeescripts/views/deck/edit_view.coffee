class DeckEditView extends Backbone.View

  template: _.template($('#deck-edit-template').html())

  initialize: ->
    @model         = new DeckApp.Deck(id: @options.id)
    @slides        = new DeckApp.Slides(deckID: @options.id)
    @slideListView = new DeckApp.SlideListView(collection: @slides)

    @model.fetch
      success: _.bind(@render, this)
      error:   _.bind(@invalidID, this)

  render: ->
    @$el.html(@template(@model.toJSON()))

    @slides.fetch()
    @$el.append(@slideListView.el)

  invalidID: (model, response) ->
    DeckApp.Util.displayNotification
      type:    'error'
      message: "A deck with an id of #{model.get('id')} does not exist, " +
               "or is inaccessible to you for editing."

    Backbone.history.navigate('decks', true)

@DeckApp = window.DeckApp || {}
@DeckApp.DeckEditView = DeckEditView
