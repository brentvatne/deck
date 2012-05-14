Util =

  vibratePaper: ->
    @vibrateElement $('#deck .paper')

  vibrateElement: (element) ->
    element.jrumble(x: 6, y: 0, rotation: 0, speed: 22)
    element.trigger('startRumble')
    setTimeout ( =>
      element.trigger('stopRumble')
    ), 300

  displayNotification: (options) ->
    @removeAnyNotifications()
    new_notification = @notification(options)
    $('body').prepend new_notification
    $('body').find('.notification').delay(3500).slideUp(600)

  removeAnyNotifications: ->
    $('body .notification').remove()

  notification: (params) ->
    notification_template = _.template($('#notification-template').html())
    notification_template(params)

@DeckApp = window.DeckApp || {}
@DeckApp.Util = Util
