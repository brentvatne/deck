class SlideEditView extends Backbone.View

  template: JST['templates/slide/edit']

  events:
    'keypress .content-area': 'delayedSave'

  initialize: ->
    @render()
    @$preview = @$el.find('.preview')
    @$content = @$el.find('.content-area')

    @model.on('change:content_as_html', @updatePreview, @)

  render: ->
    @$el.html(@template(@model.toJSON()))
    window.scrollTo(0,0)

  delayedSave: ->
    clearTimeout(@saveDelayTimer) if @saveDelayTimer

    @saveDelayTimer = setTimeout(_.bind(@saveNow, @), 500)

  saveNow: ->
    @model.save(content: @$content.val())
    @saveDelayTimer = null

  updatePreview: ->
    @$preview.html(@model.get('content_as_html'))

@da = window.da
@da.views.SlideEditView = SlideEditView
