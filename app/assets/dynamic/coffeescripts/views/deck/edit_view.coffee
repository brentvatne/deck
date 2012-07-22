class DeckEditView extends Backbone.View

  template: _.template($('#deck-edit-template').html())

  initialize: (options) ->
    da.app.currentDeck = new da.models.Deck(id: options['id'])

    da.app.currentDeck.fetch
      success: _.bind(@renderContainer, this)
      error:   _.bind(@invalidID, this)

  renderContainer: ->
    @$el.html @template(da.app.currentDeck.toJSON())

    da.app.slides.fetch
      success: _.bind(@renderSlides, this)

  renderSlides: ->
    if da.app.slides.length == 0
      slideView = new da.views.EmptySlideListView
    else
      slideView = new da.views.SlideIconListView

    @$el.append(slideView.el)


  invalidID: (model, response) ->
    da.ui.displayNotification
      type:    'error'
      message: "A deck with an id of #{model.get('id')} does not exist, " +
               "or is inaccessible to you for editing."

    Backbone.history.navigate('decks', true)

@da = window.da
@da.views.DeckEditView = DeckEditView
