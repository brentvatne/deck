class Things extends Backbone.Collection
  initialize: ->
    @on 'reset', @doSomething, this

  model: Deck.Thing

  doSomething: ->
    # whatever you want

  onlyThings: ->
    @filter (thing) ->
      thing.isAThing()

  comparator: (thing) ->
    thing.get('name')

@Deck = window.Deck || {}
@Deck.Things = new Things
