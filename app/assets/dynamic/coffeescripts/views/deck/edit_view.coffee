class DeckEditView extends Backbone.View

  template: _.template($('#deck-edit-template').html())

  initialize: (options) ->
    da.app.instances.deckEditView = this

    @deck   = new da.models.Deck(id: options.id)
    @slides = new da.collections.Slides(deckID: options.id)

    @deck.fetch
      success: _.bind(@renderContainer, this)
      error:   _.bind(@invalidID, this)

  editSlide: (slideID) ->
    # add the edit slide view to this

  renderContainer: ->
    @$el.html @template(@deck.toJSON())

    @slides.fetch
      success: _.bind(@renderSlides, this)

  renderSlides: ->
    if @slides.length == 0
      @slideListView = new da.views.EmptySlideListView(deckID: @slides.deckID)
    else
      @slideListView = new da.views.SlideListView(collection: @slides)

    @$el.append(@slideListView.el)

  invalidID: (model, response) ->
    da.ui.displayNotification
      type:    'error'
      message: "A deck with an id of #{model.get('id')} does not exist, " +
               "or is inaccessible to you for editing."

    Backbone.history.navigate('decks', true)

@da = window.da
@da.views.DeckEditView = DeckEditView
