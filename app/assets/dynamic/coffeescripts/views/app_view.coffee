class AppView extends Backbone.View
  class: 'deck-app-wrap'

  template: _.template($('#deck-app-view').html())

  initialize: ->
    @render()

    #@collection.on 'reset', @doSomething, this
    #@enableKeyboardScrolling()

    #new DeckApp.SomeNestedView(collection: @collection, app: this)

    #preloadData = @options['preloadData']
    #if preloadData then @collection.reset(preloadData) else @collection.fetch()

  render: ->
    $('#deck').empty()
    $('#deck').append(@el)
    @$el.append(@template())
    #@$el.append(@template(a_variable: "hello"))

  events:
    "click a": "doAThing"

  doAThing: (e) ->
    e?.preventDefault()
    alert 'clicked'
    #Backbone.history.navigate('some-new-path')

  enableKeyboardScrolling: ->
    #$('body').keydown (e) =>
    #  switch e.keyCode
    #    when 37 then @doAThing()
    #    when 39 then @doOtherThing()

@DeckApp = window.DeckApp || {}
@DeckApp.AppView = AppView
