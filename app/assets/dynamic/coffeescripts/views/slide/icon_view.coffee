class SlideIconView extends Backbone.View
  tagName: 'li'

  className: 'micro-slide'

  events:
    'click':                'editSlide'
    'click .right-button':  'moveSlideRight'
    'click .left-button':   'moveSlideLeft'
    'click .delete-button': 'deleteSlide'

  template: _.template($('#slide-icon-template').html())

  initialize: (options) ->
    @model        = @options.model
    @isFirstSlide = @options.isFirstSlide
    @isLastSlide  = @options.isLastSlide

    @model.on 'change', @render, this

  render: ->
    params =
      deckID:       da.app.currentDeck.get('id')
      isLastSlide:  @isLastSlide
      isFirstSlide: @isFirstSlide

    @$el.html(@template(_.extend(@model.toJSON(), params)))
    @$el.data('slide-id', @model.get('id'))
    da.ui.highlightCodeBlock(@$el)

  editSlide: (e) ->
    # navigate to new url
    console.log "edit slide"

  moveSlideRight: (e) ->
    $.ajax
      type: 'POST'
      url: @model.url() + '/move-right',
      success: -> da.app.slides.trigger('change:order')
      error: @ohShit

    e.preventDefault()
    e.stopPropagation()

  moveSlideLeft: (e) ->
    $.ajax
      type: 'POST'
      url: @model.url() + '/move-left',
      success: -> da.app.slides.trigger('change:order')
      error: @ohShit

    e.preventDefault()
    e.stopPropagation()

  deleteSlide: (e) ->
    @model.destroy
      error: @ohShit

    e.preventDefault()
    e.stopPropagation()

  ohShit: ->
    da.ui.displayNotification
      type:    'error'
      message: 'Uh oh that didnt work :( Try again!'

@da = window.da
@da.views.SlideIconView = SlideIconView
