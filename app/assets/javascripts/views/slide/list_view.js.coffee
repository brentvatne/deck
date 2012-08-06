class SlideListView extends Backbone.View
  tagName: 'ul'

  className: 'slide-list'

  initialize: ->
    da.app.instances.slideListView  = this
    da.app.instances.slideIconViews = []

    @slides = @collection
    @slides.on 'reset', @render, this

    # This is a special case because here we are using jQuery on, rather
    # than Backbone on, which accepts a third argument for execution context
    @$el.on 'sortupdate', _.bind(@updatePosition, this)

    @render()

  reloadSlides: ->
    @slides.fetch()

  render: ->
    @$el.empty()

    _.each @slides.models, (slide) =>
      slide.on 'reorder', @reloadSlides, this
      slide.on 'error:reorder', @render, this
      @$el.append (new da.views.SlideIconView(slide: slide)).el

    @$el.sortable(items: '.micro-slide')

  updatePosition: (e, args) ->
    $movedSlide  = args.item
    movedSlide   = @slides.get($movedSlide.attr('data-id'))
    newPosition  = @domPositionOfSlide($movedSlide)

    movedSlide.saveNewPosition(
      newPosition, error: _.bind(@displayPositionUpdateFailedError, this)
    )

  domPositionOfSlide: ($slide) ->
    $allSlides = @$el.find('.micro-slide')
    $allSlides.index($slide, $allSlides) + 1

  displayPositionUpdateFailedError: ->
    @render()

    da.ui.vibratePaper()
    da.ui.displayNotification
      type:    'error'
      message: 'Oops, that didn\'t work.. try again! I\'ll put that back for you.'

@da = window.da
@da.views.SlideListView = SlideListView
