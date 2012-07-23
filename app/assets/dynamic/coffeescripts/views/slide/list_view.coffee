class SlideListView extends Backbone.View
  tagName: 'ul'

  className: 'slide-list'

  initialize: ->
    da.app.instances.slideListView  = this
    da.app.instances.slideIconViews = []

    @slides = @collection
    @slides.on 'reset',        @render,       this
    @slides.on 'change:order', @slides.fetch, @slides

    # This is a special case because here we are using jQuery on, rather
    # than Backbone on, which accepts a third argument for execution context
    @$el.on 'sortupdate', _.bind(@updatePosition, this)

    @render()

  render: ->
    @$el.empty()

    _.each @slides.models, (slide) =>
      slide.on 'change:order', @render, this
      @$el.append (new da.views.SlideIconView(slide: slide)).el

    @$el.sortable(items: '.micro-slide')

  updatePosition: (e, args) ->
    $movedSlide  = args.item
    newPosition  = @domPositionOfSlide($movedSlide)

    movedSlide = @slides.get($movedSlide.attr('data-id'))
    movedSlide.updatePosition(
      newPosition, error: _.bind(@updatePositionFailed, this)
    )

  domPositionOfSlide: ($slide) ->
    $allSlides = @$el.find('.micro-slide')
    $allSlides.index($slide, $allSlides) + 1

  updatePositionFailed: ->
    # ui this didn't work

@da = window.da
@da.views.SlideListView = SlideListView
