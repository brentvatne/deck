class Slide extends Backbone.Model

  urlRoot: '/api/slides'

  saveNewPosition: (newPosition, options) ->
    $.ajax
      type: 'POST'
      data: { number: newPosition  }
      url: @url() + '/update-position',
      success: (data) =>
        @trigger('reorder')
        options.success?.call?()
      error: =>
        @trigger('error:reorder')
        options.error?.call?()

@da = window.da
@da.models.Slide = Slide
