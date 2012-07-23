class Slide extends Backbone.Model

  urlRoot: '/api/slides'

  updatePosition: (newPosition, options) ->
    console.log newPosition
    return

    $.ajax
      type: 'POST'
      data: { number: newPosition  }
      url: @url() + '/change-position',
      success: =>
        @trigger('change:number')
        @options.success?.call?()
      error: =>
        @options.error?.call?()

@da = window.da
@da.models.Slide = Slide
