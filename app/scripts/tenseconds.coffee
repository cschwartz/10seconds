@Player = cc.Sprite.extend
  init: (map, x, y) ->
    @_super()
    @map = map
    @initWithFile("player.png")
    @setPosition(cc.p(x * 64 + 32, y * 64 + 32))
    @speed = 1/2 #2 tiles per second

  canMoveForward: ->
    @map.playerCanMoveForward(@)

  moveForward: ->
    console.log("MovedForward")
    @runAction cc.Sequence.create [
      cc.MoveBy.create(@speed, @getRotatedForwardDirection())
      cc.CallFunc.create((-> @moveComplete()), @)
    ]

  rotate: (angle, tile) ->
    angleToRotate = (angle - @getRotation()) % 360
    if angleToRotate < 0
      angleToRotate += 360
    @runAction cc.Sequence.create [
      cc.RotateBy.create(@speed, angleToRotate)
      cc.CallFunc.create((-> @itemCompleted(tile)), @)
    ]

  getTilePosition: ->
    cc.p(Math.floor(@getPositionX() / 64), Math.floor(@getPositionY() / 64))

  getNextTilePosition: ->
    nextPixelPosition = cc.pAdd(@getPosition(), @getRotatedForwardDirection())
    cc.p(Math.floor(nextPixelPosition.x / 64), Math.floor(nextPixelPosition.y / 64))

  getRotatedForwardDirection: ->
    forward = cc.p(0, 64)
    angle = @getRotation()
    rotatedDirection = cc.pRotateByAngle(forward, cc.p(0, 0), cc.DEGREES_TO_RADIANS(-angle))

  itemCompleted: (tile) ->
    tile.itemCompleted(@)

  moveComplete: ->
    @map.playerMoveCompleted(@)

Player.create = (map, x, y) ->
  player = new Player()
  player.init(map, x, y)
  player


@GameLayer = cc.Layer.extend
  init: ->
    @_super()

    @map = MapOne.create()
    @addChild(@map)

    @player = Player.create(@map, 1, 1)
    @addChild(@player)

    @schedule(@update)

    @isRunning = false

    @setTouchEnabled(true)
    true

  update: (dt) ->
    if not @isRunning
      @isRunning = true
      @player.moveForward()

  createLevel: (levelName) ->
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

