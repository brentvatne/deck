class SlideIconView extends Backbone.View
  tagName: 'li'

  className: 'micro-slide'

  events:
    'click':                'editSlide'
    'click .right-button':  'moveSlideRight'
    'click .left-button':   'moveSlideLeft'
    'click .delete-button': 'deleteSlide'

  editSlide: (e) ->
    console.log "edit slide"

  moveSlideRight: (e) ->
    console.log 'move right'
    e.preventDefault()
    e.stopPropagation()

  moveSlideLeft: (e) ->
    console.log 'move left'
    e.preventDefault()
    e.stopPropagation()

  deleteSlide: (e) ->
    console.log 'delete slide'
    e.preventDefault()
    e.stopPropagation()

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
    @$el.data('slide-id', @model.get('id'))
    DeckApp.Util.highlightCodeBlock(@$el)

@DeckApp = window.DeckApp || {}
@DeckApp.SlideIconView = SlideIconView
