class LoadingNotificationView extends Backbone.View

  tagName: 'LoadingNotification'

  template: _.template($('#loading-notification-template').html())

  initialize: ->
    @render()

  render: ->
    @$el.html(@template())

@DeckApp = window.DeckApp     || {}
@DeckApp.Util = @DeckApp.Util || {}
@DeckApp.Util.LoadingNotificationView = LoadingNotificationView
