@GameLayer = cc.Layer.extend
    init: ->
      @_super()

      @setTouchEnabled(true)
      true

    menuCloseCallback: (sender) ->
      true

    onTouchesBegan: (touches, events) ->
      true

    onTouchesMoved: (touches, event) ->
      true

    onTouchesEnded: (touches, event) ->
      true

    onTouchesCancelled: (touches, event) ->
      true

@TenSecondsScene = cc.Scene.extend
  onEnter: ->
    @_super()
    layer = new GameLayer()
    layer.init()
    @addChild(layer)

