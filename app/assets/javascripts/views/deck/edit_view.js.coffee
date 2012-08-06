class DeckEditView extends Backbone.View

  template: _.template($('#deck-edit-template').html())

  initialize: (options) ->
    da.app.instances.deckEditView = this

    @deck          = new da.models.Deck(id: options.deckID)
    @slides        = new da.collections.Slides(deckID: options.deckID)
    @activeSlideID = options.slideID

    @deck.fetch
      success: _.bind(@renderContainer, this)
      error:   _.bind(@invalidID, this)

  renderContainer: ->
    @$el.html @template(@deck.toJSON())

    @slides.fetch
      success: _.bind(@renderSlides, this)

  renderSlides: ->
    @renderSlideIcons()
    @renderEditSlide()

  renderSlideIcons: ->
    @$slideListContainer = @$el.find('.slide-list-container')
    @$slideListContainer.empty()

    if @slides.length == 0
      @slideListView = new da.views.EmptySlideListView(deckID: @slides.deckID)
    else
      @slideListView = new da.views.SlideListView(collection: @slides)

    @$slideListContainer.append(@slideListView.el)

  renderEditSlide: ->
    @$slideEditContainer = @$el.find('.slide-edit-container')
    @$slideEditContainer.empty()

    @activeSlide = @slides.get(@activeSlideID)

    if @activeSlide
      @slideEditView = new da.views.SlideEditView(model: @activeSlide)
      @$slideEditContainer.append(@slideEditView.el)

  editSlide: (slideID) ->
    @activeSlideID = slideID
    @renderEditSlide()

  invalidID: (model, response) ->
    da.ui.displayNotification
      type:    'error'
      message: "A record with an id of #{model.get('id')} does not exist, " +
               "or is inaccessible to you for editing."

    Backbone.history.navigate('decks', true)

@da = window.da
@da.views.DeckEditView = DeckEditView
