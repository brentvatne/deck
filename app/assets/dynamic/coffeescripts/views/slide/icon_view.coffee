class SlideIconView extends Backbone.View
  tagName: 'li'

  className: 'micro-slide'

  events:
    'click':                'editSlide'
    'click .delete-button': 'deleteSlide'

  template: _.template $('#slide-icon-template').html()

  initialize: (options) ->
    da.app.instances.slideIconViews.push(this)

    @slide = options.slide
    @slide.on 'change', @render, this

    @render()

  render: ->
    @$el.html @template(@slide.toJSON())
    @$el.attr 'data-id', @slide.get('id')

    da.ui.highlightCodeBlock(@$el)

  editSlide: (e) ->
    # navigate to new url
    console.log "edit slide"

  deleteSlide: (e) ->
    @remove()
    @slide.destroy
      error: @displayDestroyFailedError

    e.preventDefault()
    e.stopPropagation()

  displayDestroyFailedError: ->
    da.ui.displayNotification
      type:    'error'
      message: 'Uh oh that didnt work :( Try again!'

@da = window.da
@da.views.SlideIconView = SlideIconView
