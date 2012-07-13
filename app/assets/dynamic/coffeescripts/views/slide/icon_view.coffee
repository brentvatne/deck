class SlideIconView extends Backbone.View
  tagName: 'li'

  className: 'micro-slide'

  events:
    'click':                'editSlide'
    'click .right-button':  'moveSlideRight'
    'click .left-button':   'moveSlideLeft'
    'click .delete-button': 'deleteSlide'

  editSlide: (e) ->
    # navigate to new url
    console.log "edit slide"

  moveSlideRight: (e) ->
    $.ajax
      type: 'POST'
      url: @model.url() + '/move-right',
      success: => @model.trigger('sync')
      error: @ohShit

    e.preventDefault()
    e.stopPropagation()

  moveSlideLeft: (e) ->
    $.ajax
      type: 'POST'
      url: @model.url() + '/move-left',
      success: => @model.trigger('sync')
      error: @ohShit

    e.preventDefault()
    e.stopPropagation()

  deleteSlide: (e) ->
    @model.destroy
      error: @ohShit

    e.preventDefault()
    e.stopPropagation()

  ohShit: ->
    DeckApp.Util.displayNotification
      type:    'error'
      message: 'Uh oh that didnt work :( Try again!'

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
