class PresentationView extends Backbone.View

  template: JST['templates/presentation']

  initialize: (options) ->
    da.app.instances.presentationView = this

    @deck          = new da.models.Deck(id: options.deckID)
    @slides        = new da.collections.Slides(deckID: options.deckID)
    @activeSlideID = options.slideID

    @deck.fetch
      success: _.bind(@renderLayout, this)
      error:   _.bind(@invalidDeckID, this)

  renderLayout: ->
    @slides.fetch
      success: _.bind(@beginPresentation, this)

  beginPresentation: ->
    @enableKeyboardScrolling()
    @showSlide(@activeSlideID)

  showSlide: (slideID) ->
    @invalidSlideID() if slideID > @slides.size() + 1
    @activeSlide = @slides.at(@activeSlideID - 1)
    @$el.html(@activeSlide.get('content_as_html'))

  invalidDeckID: (model, response) ->
    da.ui.displayNotification
      type:    'error'
      message: "Oops, it seems that presentation doesn't exist."

    Backbone.history.navigate('decks', true)

  invalidSlideID: (model, response) ->
    da.ui.displayNotification
      type:    'error'
      message: "Sorry buddy, presentation is over."

    Backbone.history.navigate('decks', true)

  navigateToPrevSlide: ->
    if @activeSlideID > 1
      @activeSlideID = parseInt(@activeSlideID) - 1
      @showSlide(@activeSlideID)

  navigateToNextSlide: ->
    if @activeSlideID < @slides.size()
      @activeSlideID = parseInt(@activeSlideID) + 1
      @showSlide(@activeSlideID + 1)

  enableKeyboardScrolling: ->
    $('body').keydown (e) =>
      switch e.keyCode
        when 37 then @navigateToPrevSlide()
        when 39 then @navigateToNextSlide()

@da = window.da
@da.views.PresentationView = PresentationView
