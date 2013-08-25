@Player = cc.Sprite.extend
  init: (game, map) ->
    @_super()
    @game = game
    @map = map
    @initWithFile("player.png")
    playerStart = @map.getPlayerStart()
    @setPosition(cc.p(playerStart.x * 64 + 32, playerStart.y * 64 + 32))
    @setRotation(playerStart.rotation)
    @speed = 4 #2 tiles per second

  canMoveForward: ->
    @map.playerCanMoveForward(@)

  moveForward: ->
    @runAction cc.Sequence.create [
      cc.MoveBy.create(1/@speed, @getRotatedForwardDirection())
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
        cc.RotateBy.create(1/@speed, angleToRotate)
        cc.CallFunc.create((-> @itemCompleted(tile)), @)
      ]
    else 
      @runAction cc.Sequence.create [
        cc.CallFunc.create((-> @itemCompleted(tile)), @)
      ]

  speedUp: (tile) ->
    @speed *= 4
    @runAction cc.Sequence.create [
      cc.CallFunc.create((-> @itemCompleted(tile)), @)
    ]
  teleport: (destination, tile) ->
    @runAction cc.Sequence.create [
      cc.Place.create(cc.p(32 + destination.x * 64, 32 + destination.y * 64)),
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
    tile.itemCompleted()

  moveComplete: ->
    @map.playerMoveCompleted(@)

  levelComplete: ->
    @game.levelComplete()

Player.create = (game, map, x, y) ->
  player = new Player()
  player.init(game, map, x, y)
  player


