@ChangeDirection = cc.Sprite.extend
  init: (description) ->
    @_super()
    @initWithFile(change_direction)
    @setPosition(cc.p(32, 32))
    @setRotation(description.newDirection)

  interact: (player, tile) ->
    player.rotate(@getRotation(), tile)

ChangeDirection.create = (description) ->
  item = new ChangeDirection()
  item.init(description)
  item
