@Player = cc.Sprite.extend
  init: (game, map, x, y) ->
    @_super()
    @game = game
    @map = map
    @initWithFile("player.png")
    @setPosition(cc.p(x * 64 + 32, y * 64 + 32))
    @speed = 1/4 #2 tiles per second

  canMoveForward: ->
    @map.playerCanMoveForward(@)

  moveForward: ->
    @runAction cc.Sequence.create [
      cc.MoveBy.create(@speed, @getRotatedForwardDirection())
      cc.CallFunc.create((-> @moveComplete()), @)
    ]

  rotate: (angle, tile) ->
    angleToRotate = (angle - @getRotation()) % 360
    if Math.abs(angleToRotate) > 180
      if angleToRotate > 0
        angleToRotate -= 360
      else
        angleToRotate += 360
    if angleToRotate != 0
      @runAction cc.Sequence.create [
        cc.RotateBy.create(@speed, angleToRotate)
        cc.CallFunc.create((-> @itemCompleted(tile)), @)
      ]
    else 
      @runAction cc.Sequence.create [
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

  levelComplete: ->
    @game.levelComplete()

Player.create = (game, map, x, y) ->
  player = new Player()
  player.init(game, map, x, y)
  player


