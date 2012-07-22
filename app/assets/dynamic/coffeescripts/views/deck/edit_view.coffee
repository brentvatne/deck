class DeckEditView extends Backbone.View

  template: _.template($('#deck-edit-template').html())

  initialize: ->
    D.currentDeck = new D.Deck(id: D.currentDeckID)

    D.currentDeck.fetch
      success: _.bind(@renderContainer, this)
      error:   _.bind(@invalidID, this)

  renderContainer: ->
    @$el.html(@template(D.currentDeck.toJSON()))

    D.Slides.fetch
      success: _.bind(@renderSlides, this)

  renderSlides: ->
    if D.Slides.length == 0
      @slideView = new D.EmptySlideListView
    else
      @slideView = new D.SlideIconListView

    @$el.append(@slideView.el)


  invalidID: (model, response) ->
    D.Util.displayNotification
      type:    'error'
      message: "A deck with an id of #{model.get('id')} does not exist, " +
               "or is inaccessible to you for editing."

    Backbone.history.navigate('decks', true)

@D = window.D || {}
@D.DeckEditView = DeckEditView
