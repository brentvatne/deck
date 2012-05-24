Util =
  showLoading: ->
    @loadingNotification = new DeckApp.Util.LoadingNotificationView
    $('.paper').append(@loadingNotification.el)

  hideLoading: ->
    @loadingNotification?.remove()

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

  highlightCodeBlock: (block) ->
    codeBlocks = block.find('pre code')
    if codeBlocks
      codeBlocks.each (i, e) -> hljs.highlightBlock(e)

@DeckApp = window.DeckApp     || {}
@DeckApp.Util = _.extend(@DeckApp.Util, Util)
