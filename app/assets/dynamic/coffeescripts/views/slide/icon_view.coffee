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
    da.app.instances.slideIconView ||= {}
    da.app.instances.slideIconView << this

    @slide        = options.slide
    @isFirstSlide = options.isFirstSlide
    @isLastSlide  = options.isLastSlide

    @slide.on 'change', @render, this
    @render()

  render: ->
    params =
      isLastSlide:  @isLastSlide
      isFirstSlide: @isFirstSlide

    @$el.html(@template(_.extend(@slide.toJSON(), params)))
    @$el.data('slide-id', @slide.get('id'))
    da.ui.highlightCodeBlock(@$el)

  editSlide: (e) ->
    # navigate to new url
    console.log "edit slide"

  moveSlideRight: (e) ->
    $.ajax
      type: 'POST'
      url: @slide.url() + '/move-right',
      success: => @slide.trigger('change:order')
      error: @ohShit

    e.preventDefault()
    e.stopPropagation()

  moveSlideLeft: (e) ->
    $.ajax
      type: 'POST'
      url: @slide.url() + '/move-left',
      success: => @slide.trigger('change:order')
      error: @ohShit

    e.preventDefault()
    e.stopPropagation()

  deleteSlide: (e) ->
    @slide.destroy
      error: @ohShit

    e.preventDefault()
    e.stopPropagation()

  ohShit: ->
    da.ui.displayNotification
      type:    'error'
      message: 'Uh oh that didnt work :( Try again!'

@da = window.da
@da.views.SlideIconView = SlideIconView
