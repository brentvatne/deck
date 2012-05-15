class SlideIconView extends Backbone.View
  tagName: 'li'

  className: 'micro-slide'

  template: _.template($('#slide-icon-template').html())

  initialize: (options) ->
    @model        = @options.model
    @deckID       = @options.deckID
    @isFirstSlide = @options.isFirstSlide
    @isLastSlide  = @options.isLastSlide

    @model.on 'change', @render, this

  render: ->
    params =
      deckID:       @deckID
      isLastSlide:  @isLastSlide
      isFirstSlide: @isFirstSlide

    @$el.html(@template(_.extend(@model.toJSON(), params)))
    DeckApp.Util.highlightCodeBlock(@$el)

@DeckApp = window.DeckApp || {}
@DeckApp.SlideIconView = SlideIconView
